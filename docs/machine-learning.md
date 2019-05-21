# Machine Learning (ML)

  - [Machine learning \- Wikipedia](https://en.wikipedia.org/wiki/Machine_learning) #ril

      - Machine learning (ML) is the scientific study of ALGORITHMS and STATISTICAL MODELS that computer systems use to effectively perform a specific task without using EXPLICIT INSTRUCTIONS, relying on PATTERNS and INFERENCE instead.

        It is seen as A SUBSET OF ARTIFICIAL INTELLIGENCE. Machine learning algorithms build a MATHEMATICAL MODEL BASED ON SAMPLE DATA, known as "TRAINING DATA", in order to make PREDICTIONS or DECISIONS without being explicitly programmed to perform the task.

      - Machine learning algorithms are used in a wide variety of applications, such as email filtering, and computer vision, where it is INFEASIBLE to develop an algorithm of specific instructions for performing the task. Machine learning is closely related to computational statistics, which focuses on making predictions using computers. The study of MATHEMATICAL OPTIMIZATION delivers methods, theory and application domains to the field of machine learning.

      - DATA MINING is a field of study within machine learning, and focuses on EXPLORATORY DATA ANALYSIS through UNSUPERVISED LEARNING. In its application across business problems, machine learning is also referred to as predictive analytics.

    Overview

      - The name machine learning was coined in 1959 by Arthur Samuel. Tom M. Mitchell provided a widely quoted, more formal definition of the algorithms studied in the machine learning field:

        > A computer program is said to LEARN FROM EXPERIENCE E with respect to some class of tasks T and performance measure P if its performance at tasks in T, as measured by P, improves with experience E.

        This definition of the tasks in which machine learning is concerned offers a fundamentally OPERATIONAL definition rather than defining the field in COGNITIVE terms. 不過就很侷限於 "some class of tasks"

      - This follows Alan Turing's proposal in his paper "Computing Machinery and Intelligence", in which the question "Can machines THINK?" is replaced with the question "Can machines do what we (as thinking entities) can do?". In Turing's proposal the various characteristics that could be possessed by a thinking machine and the various implications in constructing one are exposed.

    Machine learning tasks

      - Machine learning tasks are classified into several broad categories.

      - In SUPERVISED LEARNING, the algorithm builds a mathematical model from a set of data that contains both the inputs and the DESIRED OUTPUTS. For example, if the task were determining whether an image contained a certain object, the training data for a supervised learning algorithm would include images WITH AND WITHOUT that object (the input), and each image would have a LABEL (the output) designating whether it contained the object.

        In special cases, the input may be only partially available, or restricted to special feedback.

      - SEMI-SUPERVISED LEARNING algorithms develop mathematical models from INCOMPLETE training data, where a PORTION of the sample input DOESN'T HAVE LABELS.

      - CLASSIFICATION algorithms and REGRESSION algorithms are types of supervised learning.

        Classification algorithms are used when the OUTPUTS ARE RESTRICTED TO A LIMITED SET OF VALUES. For a classification algorithm that filters emails, the input would be an incoming email, and the output would be the name of the folder in which to file the email. For an algorithm that identifies spam emails, the output would be the prediction of either "spam" or "not spam", represented by the Boolean values true and false.

        Regression algorithms are named for their CONTINUOUS OUTPUTS, meaning they may have ANY VALUE WITHIN A RANGE. Examples of a continuous value are the temperature, length, or price of an object.

      - In UNSUPERVISED LEARNING, the algorithm builds a mathematical model from a set of data which contains ONLY INPUTS AND NO DESIRED OUTPUT LABELS. Unsupervised learning algorithms are used to FIND STRUCTURE IN THE DATA, like grouping or clustering of data points.

        Unsupervised learning can DISCOVER PATTERNS IN THE DATA, and can group the inputs into categories, as in feature learning. DIMENSIONALITY REDUCTION is the process of reducing the number of "features", or inputs, in a set of data.

        Unsupervised learning 可以幫忙從大量的資料中找出分類的方式，似乎可以做為 supervised learning 分析的指標/因素 ??

  - [Supervised learning \- Wikipedia](https://en.wikipedia.org/wiki/Supervised_learning) #ril
  - [Semi\-supervised learning \- Wikipedia](https://en.wikipedia.org/wiki/Semi-supervised_learning) #ril
  - [Unsupervised learning \- Wikipedia](https://en.wikipedia.org/wiki/Unsupervised_learning) #ril

## 參考資料 {: #reference }

相關：

  - 屬於 [AI](ai.md) 的一環
  - [Deep Learning](deep-learning.md)

