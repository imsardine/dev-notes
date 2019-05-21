# Database

  - [Database \- Wikipedia](https://en.wikipedia.org/wiki/Database) #ril

## Transaction ??

  - [Database transaction \- Wikipedia](https://en.wikipedia.org/wiki/Database_transaction) #ril
  - [Distributed transaction \- Wikipedia](https://en.wikipedia.org/wiki/Distributed_transaction) #ril

## Isolation ??

  - [Isolation \(database systems\) \- Wikipedia](https://en.wikipedia.org/wiki/Isolation_(database_systems))

      - In database systems, isolation determines HOW TRANSACTION INTEGRITY IS VISIBLE TO OTHER USERS and systems. For example, when a user is creating a Purchase Order and has created the header, but not the Purchase Order lines, is the header available for other systems/users (carrying out concurrent operations, such as a report on Purchase Orders) to see? (Refers to current, not past database systems)

      - A lower ISOLATION LEVEL increases the ability of MANY USERS TO ACCESS THE SAME DATA AT THE SAME TIME, but increases the number of CONCURRENCY EFFECTS (such as DIRTY READS or LOST UPDATES) users might encounter. Conversely, a higher isolation level reduces the types of concurrency effects that users may encounter, but requires more system resources and INCREASES THE CHANCES THAT ONE TRANSACTION WILL BLOCK ANOTHER.

        這是一種權衡，isolation level 有高有低；由低到高時，cocurrent 的問題會比較少，但 transaction 要停下來等別人或發生 deadlock 的機會就會昇高。

        雖然下面 Read phenomena 沒提到 lost updates，但似乎跟 non-repeatable reads 有關? 由於另一個 transaction 可以修改已經讀取的資料，若拿此過時的資料做點運算再寫回去，那麼另一個 transaction 所做的修改就會不見。

      - Isolation is typically defined at DATABASE LEVEL as a property that defines HOW/WHEN THE CHANGES made by one operation BECOME VISIBLE TO OTHER. On older systems, it may be implemented systemically, for example through the use of temporary tables.

        In two-tier systems, a Transaction Processing (TP) manager is required to maintain isolation. In n-tier systems (such as multiple websites attempting to book the last seat on a flight), a combination of stored procedures and transaction management is required to commit the booking and send confirmation to the customer.

        為什麼 n-tier 跟 store procedure 的使用有關??

      - Isolation is one of the ACID (Atomicity, Consistency, Isolation, Durability) properties.

    Concurrency control

      - Concurrency control comprises the UNDERLYING MECHANISMS in a DBMS which handle isolation and GUARANTEE RELATED CORRECTNESS. It is heavily used by the database and storage engines (see above) both to guarantee the correct execution of concurrent transactions, and (different mechanisms) the correctness of other DBMS processes.

        Concurrency control 就是 isolation 的實作方式，這裡沒特別說明有哪些選擇，不過下面不斷提到 lock-based concurrency control 及 multiversion concurrency control (MVCC)；但這似乎不是單選題，因為 MySQL InnoDB 同時支援了 table-/row-level locking 與 MVCC。

        The transaction-related mechanisms typically constrain the database DATA ACCESS OPERATIONS' TIMING (transaction schedules) to certain orders characterized as the SERIALIZABILITY and RECOVERABILITY schedule properties. Constraining database access operation execution typically means REDUCED PERFORMANCE (rates of execution), and thus concurrency control mechanisms are typically designed to provide the best performance possible under the constraints. Often, when possible without harming correctness, the serializability property is compromised for better performance. However, RECOVERABILITY CANNOT BE COMPROMISED, since such typically results in a quick database integrity violation.

      - TWO-PHASE LOCKING is the most common transaction concurrency control method in DBMSs, used to provide both serializability and recoverability for correctness. In order to access a database object a transaction first needs to ACQUIRE A LOCK for this object. Depending on the access operation type (e.g., reading or writing an object) and on the lock type, acquiring the lock MAY BE BLOCKED AND POSTPONED, if another transaction is holding a lock for that object.

        根據 [Two\-phase locking \- Wikipedia](https://en.wikipedia.org/wiki/Two-phase_locking)，所謂 two-phase 指的是 expanding phase (locks are acquired and no locks are released) 與 shrinking phase (locks are released and no locks are acquired)，也就是 lock 只會在 transaction 結束前 release ??

  - [Read phenomena - Isolation \(database systems\) \- Wikipedia](https://en.wikipedia.org/wiki/Isolation_(database_systems)#Read_phenomena) #ril

    這裡說明多個 tranaction 同時發生時，資料層面可能的各種問題；這些問題會隨著 isolation level 提高而減輕，背後 cocurrency control 的實作方式也可能造成影響。

      - The ANSI/ISO standard SQL 92 refers to three different READ PHENOMENA when Transaction 1 reads data that Transaction 2 MIGHT HAVE CHANGED.

        In the following examples, two transactions take place. In the first, Query 1 is performed. Then, in the second transaction, Query 2 is performed AND COMMITTED. Finally, in the first transaction, Query 1 is PERFORMED AGAIN.

        這說明有點怪，因為就算 T2 還沒 commit，也可能因為 isolation level 不夠高而引發一些問題，而且問題也不一定跟重新 query 有關 ... 雖然先 query 過取得 lock 可能緩解問題。

        The queries use the following data table:

        | id | name | age |
        |----|------|-----|
        | 1  | Joe  | 20  |
        | 2  | Jill | 25  |

    Dirty reads

      - A DIRTY READ (aka UNCOMMITTED DEPENDENCY) occurs when a transaction is allowed to read data from a row that has been modified by another running transaction and NOT YET COMMITTED.

      - Dirty reads work similarly to NON-REPEATABLE READS; however, the second transaction would not need to be committed for the first query to return a different result.

        The only thing that may be prevented in the READ UNCOMMITTED isolation level is updates appearing OUT OF ORDER in the results; that is, earlier updates will always appear in a result set before later updates.

        這裡沒講明的是，dirty read 只會發生在 READ UNCOMMITTED + lock-based concurrency control。

      - In our example, Transaction 2 changes a row, but does not commit the changes. Transaction 1 then reads the uncommitted data. Now if Transaction 2 rolls back its changes (already read by Transaction 1) or updates different changes to the database, then the view of the data may be wrong in the records of Transaction 1.

            Transaction 1       Transaction 2

            /* Query 1 */
            SELECT age FROM users WHERE id = 1;
            /* will read 20 */

                                /* Query 2 */
                                UPDATE users SET age = 21 WHERE id = 1;
                                /* No commit here */

            /* Query 1 */
            SELECT age FROM users WHERE id = 1;
            /* will read 21 */

                                ROLLBACK; /* lock-based DIRTY READ */

        But in this case no row exists that has an id of 1 and an age of 21.

        這個問題 T1 不一定要先執行過，就 dirty read 而言，關鍵在 T2 最後 rollback 了，而 query 1 兩次讀到不同的值，只是同時表現出 non-repeatable reads 的問題；如果 T2 最後 commit 了就沒事，但 rollback 了反而讓讀到的資料變 dirty 了。

    Non-repeatable reads

      - A NON-REPEATABLE READ occurs, when DURING THE COURSE OF A TRANSACTION, a row is RETRIEVED TWICE and the values within the row differ between reads.

      - Non-repeatable reads phenomenon may occur in a LOCK-BASED CONCURRENCY CONTROL method when READ LOCKS ARE NOT ACQUIRED WHEN PERFORMING A SELECT, or when the acquired locks on affected rows are released as soon as the SELECT operation is performed. Under the MULTIVERSION CONCURRENCY CONTROL method, non-repeatable reads may occur when the requirement that a transaction affected by a commit conflict must roll back is relaxed.

            Transaction 1       Transaction 2

            /* Query 1 */
            SELECT * FROM users WHERE id = 1;

                                /* Query 2 */
                                UPDATE users SET age = 21 WHERE id = 1;
                                COMMIT; /* in multiversion concurrency
                                   control, or lock-based READ COMMITTED */

            /* Query 1 */
            SELECT * FROM users WHERE id = 1;
            COMMIT; /* lock-based REPEATABLE READ */

      - In this example, Transaction 2 commits successfully, which means that its changes to the row with id 1 should become visible. However, Transaction 1 HAS ALREADY SEEN A DIFFERENT VALUE for age in that row. At the SERIALIZABLE and REPEATABLE READ isolation levels, the DBMS must return the old value for the second SELECT. At READ COMMITTED and READ UNCOMMITTED, the DBMS may return the updated value; this is a non-repeatable read.

      - There are two basic STRATEGIES used to prevent non-repeatable reads. The first is to DELAY the execution of Transaction 2 until Transaction 1 has committed or rolled back. This method is used when LOCKING is used, and produces the SERIAL SCHEDULE T1, T2. A serial schedule exhibits repeatable reads behaviour.

        這時候 query 1 先執行過就很重要 -- 才知道 lock 要放在哪個 record 上。

      - In the other strategy, as used in multiversion concurrency control, Transaction 2 is permitted to commit first, which provides for BETTER CONCURRENCY. However, Transaction 1, which commenced prior to Transaction 2, must continue to operate on a past version of the database — a SNAPSHOT of the moment it was started. When Transaction 1 eventually tries to commit, the DBMS checks if the result of committing Transaction 1 would be EQUIVALENT TO THE SCHEDULE T1, T2. If it is, then Transaction 1 can proceed. If it cannot be seen to be equivalent, however, Transaction 1 must roll back with a SERIALIZATION FAILURE.

        好奇所謂 equivalent 是怎麼判斷的? 會不會造成誤判?? 因為我們可以根據有問題的 A 去更新 B，這時候根本不會產生 write collision?

      - Using a lock-based concurrency control method, at the REPEATABLE READ isolation mode, the row with ID = 1 would be locked, thus blocking Query 2 until the first transaction was committed or rolled back. In READ COMMITTED mode, the second time Query 1 was executed, the age would have changed.

        也就是 REPEATABLE READ 才會讓 T1 在 `SELECT` 時就取得 (read) lock，讓 T2 要停下來等；相對地，READ COMMITTED 不會讓 T1 在 `SELECT` 時就取得 lock，所以 T2 可以走到 commit，之後 T1 若重新 query，就會拿到 T2 更新的結果 -- 不是 dirty，但跟第一次 query 的結果不同，也就是 non-repeatable reads。

        若 T2 也是單純做 `SELECT` 會要停下來等嗎?? 在 ORM 裡如果已經讀進來但尚未取得 lock，要如何事後取得 lock??

      - Under multiversion concurrency control, at the SERIALIZABLE isolation level, both `SELECT` queries see a snapshot of the database taken at the start of Transaction 1. Therefore, they return the same data. However, if Transaction 1 then attempted to `UPDATE` that row as well, a serialization failure would occur and Transaction 1 would be forced to roll back.

      - At the READ COMMITTED isolation level, each query sees a snapshot of the database taken at the START OF EACH QUERY. Therefore, they each see different data for the updated row. No serialization failure is possible in this mode (because no promise of serializability is made), and Transaction 1 will not have to be retried. ??

    Phantom reads

      - A PHANTOM READ occurs when, in the COURSE OF A TRANSACTION, NEW ROWS ARE ADDED OR REMOVED by another transaction to the records being read.
      - This can occur when RANGE LOCKS are not acquired on performing a `SELECT ... WHERE` operation. The phantom reads anomaly is a SPECIAL CASE OF NON-REPEATABLE READS when Transaction 1 repeats a ranged `SELECT ... WHERE` query and, between both operations, Transaction 2 creates (i.e. `INSERT`) new rows (in the target table) which fulfill that `WHERE` clause.

            Transaction 1       Transaction 2

            /* Query 1 */
            SELECT * FROM users
            WHERE age BETWEEN 10 AND 30;

                                /* Query 2 */
                                INSERT INTO users(id,name,age) VALUES ( 3, 'Bob', 27 );
                                COMMIT;

            /* Query 1 */
            SELECT * FROM users
            WHERE age BETWEEN 10 AND 30;
            COMMIT;

      - Note that Transaction 1 executed the same query twice. If the highest level of isolation were maintained, the same set of rows should be returned both times, and indeed that is what is mandated to occur in a database operating at the `SQL SERIALIZABLE` isolation level. However, at the lesser isolation levels, a different set of rows may be returned the second time.
      - In the `SERIALIZABLE` isolation mode, Query 1 would result in all records with age in the range 10 to 30 being locked, thus Query 2 would block until the first transaction was committed. In `REPEATABLE READ` mode, the range would not be locked, allowing the record to be inserted and the second execution of Query 1 to include the new row in its results.

  - [Isolation levels - Isolation \(database systems\) \- Wikipedia](https://en.wikipedia.org/wiki/Isolation_(database_systems)#Isolation_levels)

      - Of the four ACID properties in a DBMS (Database Management System), the isolation property is the one most often RELAXED. When attempting to maintain the highest level of isolation, a DBMS usually acquires locks on data which may result in a loss of concurrency or implements multiversion concurrency control. This requires adding logic for the application to function correctly.

      - Most DBMSs offer a number of transaction isolation levels, which control the DEGREE OF LOCKING that occurs when selecting data. For many database applications, the majority of database transactions can be constructed to avoid requiring high isolation levels (e.g. SERIALIZABLE level), thus reducing the locking overhead for the system.

        The programmer must CAREFULLY ANALYZE DATABASE ACCESS CODE TO ENSURE THAT ANY RELAXATION OF ISOLATION DOES NOT CAUSE SOFTWARE BUGS that are difficult to find. Conversely, if higher isolation levels are used, the POSSIBILITY OF DEADLOCK IS INCREASED, which also requires careful analysis and programming techniques to avoid.

      - The isolation levels defined by the ANSI/ISO SQL standard are listed as follows.

    Serializable

      - This is the highest isolation level. With a lock-based concurrency control DBMS implementation, serializability requires read and write locks (acquired on selected data) to be released at the end of the transaction. Also range-locks must be acquired when a `SELECT` query uses a ranged `WHERE` clause, especially to avoid the phantom reads phenomenon.
      - When using non-lock based concurrency control, no locks are acquired; however, if the system DETECTS A WRITE COLLISION among several concurrent transactions, only one of them is allowed to commit. See snapshot isolation for more details on this topic.

      - From : (Second Informal Review Draft) ISO/IEC 9075:1992, Database Language SQL- July 30, 1992:

        The execution of concurrent SQL-transactions at isolation level SERIALIZABLE is guaranteed to be serializable. A serializable execution is defined to be an execution of the operations of concurrently executing SQL-transactions that produces the same effect as some serial execution of those same SQL-transactions. A serial execution is one in which each SQL-transaction executes to completion before the next SQL-transaction begins.

    Repeatable reads

      - In this isolation level, a lock-based concurrency control DBMS implementation keeps read and write locks (acquired on selected data) until the end of the transaction. However, RANGE-LOCKS ARE NOT MANAGED, so phantom reads can occur.

        Write skew is possible at this isolation level, a phenomenon where two writes are allowed to the same column(s) in a table by two different writers (who have previously read the columns they are updating), resulting in the column having data that is a mix of the two transactions.

    Read committed

      - In this isolation level, a lock-based concurrency control DBMS implementation keeps WRITE LOCKS (acquired on selected data) until the end of the transaction, but READ LOCKS ARE RELEASED AS SOON AS THE `SELECT` OPERATION IS PERFORMED (so the non-repeatable reads phenomenon can occur in this isolation level). As in the previous level, range-locks are not managed.

      - Putting it in simpler words, read committed is an isolation level that guarantees that any data read is committed at the moment it is read. It simply restricts the reader from seeing any intermediate, uncommitted, 'dirty' read. It makes no promise whatsoever that if the transaction RE-ISSUES THE READ, it will find the same data; data is free to change after it is read.

        若有使用 ORM，幾乎不會有重讀一次的狀況??

    Read uncommitted

      - This is the lowest isolation level. In this level, dirty reads are allowed, so one transaction may see not-yet-committed changes made by other transactions.

    Since each isolation level is stronger than those below, in that no higher isolation level allows an action forbidden by a lower one, the standard permits a DBMS to run a transaction at an isolation level stronger than that requested (e.g., a "Read committed" transaction may actually be performed at a "Repeatable read" isolation level). ??

    Default isolation level

      - The default isolation level of different DBMS's varies quite widely. Most databases that feature transactions allow the user to set any isolation level. Some DBMS's also require additional syntax when performing a `SELECT` statement to acquire locks (e.g. `SELECT ... FOR UPDATE` to acquire EXCLUSIVE WRITE LOCKS on accessed rows).

      - However, the definitions above have been criticized as being ambiguous, and as not accurately reflecting the isolation provided by many databases:

        > This paper shows a number of weaknesses in the anomaly approach to defining isolation levels. The three ANSI phenomena are ambiguous, and even in their loosest interpretations do not exclude some anomalous behavior ... This leads to some counter-intuitive results. In particular, lock-based isolation levels have different characteristics than their ANSI equivalents. This is disconcerting because commercial database systems typically use locking implementations. Additionally, the ANSI phenomena do not distinguish between a number of types of isolation level behavior that are popular in commercial systems.

      - There are also other criticisms concerning ANSI SQL's isolation definition, in that it encourages implementors to do "bad things":

        > ... it relies in subtle ways on an assumption that a locking schema is used for concurrency control, as opposed to an optimistic or multi-version concurrency scheme. This implies that the proposed semantics are ill-defined.

    Isolation levels, read phenomena, and locks

      - Isolation levels vs read phenomena

        | Isolation level  | Dirty reads | Lost updates | Non-repeatable reads | Phantoms    |
        |------------------|-------------|--------------|----------------------|-------------|
        | Read Uncommitted | may occur   | may occur    | may occur            | may occur   |
        | Read Committed   | don't occur | may occur    | may occur            | may occur   |
        | Repeatable Read  | don't occur | don't occur  | don't occur          | may occur   |
        | Serializable     | don't occur | don't occur  | don't occur          | don't occur |

      - If all transactions operate with Repeatable Read or Serializable then LOST UPDATES don't occur.
      - Anomaly Serializable is not the same as Serializable. That is, it is necessary, but not sufficient that a Serializable schedule should be free of all three phenomena types.

  - [Two\-phase locking \- Wikipedia](https://en.wikipedia.org/wiki/Two-phase_locking) #ril

  - [mysql \- When to use SELECT \.\.\. FOR UPDATE? \- Stack Overflow](https://stackoverflow.com/questions/10935850/) Quassnoi: #ril

      - The only PORTABLE way to achieve consistency between rooms and tags and making sure rooms are never returned after they had been deleted is locking them with `SELECT FOR UPDATE`.
      - However in some systems locking is a SIDE EFFECT of concurrency control, and you achieve the same results without specifying `FOR UPDATE` explicitly.

    > To solve this problem, Thread 1 should `SELECT id FROM rooms FOR UPDATE`, thereby preventing Thread 2 from deleting from rooms until Thread 1 is done. Is that correct?

    This depends on the concurrency control your database system is using.

      - In databases which use MVCC (like Oracle, PostgreSQL, MySQL with InnoDB), a DML query creates a copy of the record (in one or another way) and generally READERS DO NOT BLOCK WRITERS AND VICE VERSA. For these databases, a `SELECT FOR UPDATE` would come handy: it would lock either `SELECT` or the `DELETE` query until another session commits, just as SQL Server does.

    > When should one use `REPEATABLE_READ` transaction isolation versus `READ_COMMITTED` with `SELECT ... FOR UPDATE`?

      - Generally, `REPEATABLE READ` does not forbid phantom rows (rows that appeared or disappeared in another transaction, rather than being modified)
      - In InnoDB, `REPEATABLE READ` and `SERIALIZABLE` are different things: readers in `SERIALIZABLE` mode set NEXT-KEY LOCKS on the records they evaluate, effectively preventing the concurrent DML on them. So you don't need a `SELECT FOR UPDATE` in serializable mode, but do need them in `REPEATABLE READ` or `READ COMMITED`.
