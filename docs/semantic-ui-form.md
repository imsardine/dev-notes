---
title: Semantic UI / Form
---
# [Semantic UI](semantic-ui.md) / Form

  - [Form \| Semantic UI](https://semantic-ui.com/collections/form.html) #ril
      - A form displays a set of related user input fields in a STRUCTURED WAY 要排好這些 form elements 確實不容易，上下左右都要對齊，很累人!!

            <form class="ui form">
              <div class="field">
                <label>First Name</label>
                <input type="text" name="first-name" placeholder="First Name">
              </div>
              <div class="field">
                <label>Last Name</label>
                <input type="text" name="last-name" placeholder="Last Name">
              </div>
              <div class="field">
                <div class="ui checkbox">
                  <input type="checkbox" tabindex="0" class="hidden">
                  <label>I agree to the Terms and Conditions</label>
                </div>
              </div>
              <button class="ui button" type="submit">Submit</button> <-- 不用 <input type="submit"> ??
            </form>

        結構上是 form (`<form class="ui form">`) 下面有許多 field (`<div class="field">`)，每個 field 除了 form element 外 (並沒有特別，就是 `<input ...>` 的寫法，這一點跟動態產生 form element 的 framework 很搭)，都可以有個 label (`<label>`)。

        事實上，在 field 下的 label 是針對整個 field，如果 field 裡有多個 form element，則各自會有自己的 label，例如：

            <div class="field">
              <label>Aggrements</label> <-- 給 field
              <div class="ui checkbox">
                <input type="checkbox" tabindex="0" class="hidden">
                <label>I agree to the Terms and Conditions</label> <-- 給單一個 checkbox
              </div>
            </div>

      - 下面 Shipping Information 示範了更複雜的排版

            <form class="ui form">
              <h4 class="ui dividing header">Shipping Information</h4> <-- 跟 divider header 不同
              <div class="field"> <-- 第一層 field 是 row
                <label>Name</label>
                <div class="two fields">
                  <div class="field"> <-- Field 下還可以有 fields，第二層 field 分 columns
                    <input type="text" name="shipping[first-name]" placeholder="First Name"> <-- name 的表示法好特別??
                  </div>
                  <div class="field">
                    <input type="text" name="shipping[last-name]" placeholder="Last Name">
                  </div>
                </div>
              </div>
              <div class="field">
                <label>Billing Address</label>
                <div class="fields"> <-- 只寫 fields，比例下一層 field 再指定
                  <div class="twelve wide field"> <-- twelve v. four，是 3:1 的意思
                    <input type="text" name="shipping[address]" placeholder="Street Address">
                  </div>
                  <div class="four wide field">
                    <input type="text" name="shipping[address-2]" placeholder="Apt #">
                  </div>
                </div>
              </div>
              <div class="two fields">
                <div class="field">
                  <label>State</label>
                  <div class="ui fluid dropdown selection" tabindex="0"><select>
                    <option value="">State</option>
                <option value="AL">Alabama</option>
                ...
                <option value="WY">Wyoming</option>
                  </select><i class="dropdown icon"></i><div class="default text">State</div><div class="menu" tabindex="-1"><div class="item" data-value="AL">Alabama</div>...</div></div>
                </div>
                <div class="field">
                  <label>Country</label>
                  <div class="ui fluid search selection dropdown">
                    <input type="hidden" name="country">
                    <i class="dropdown icon"></i>
                    <input class="search" autocomplete="off" tabindex="0"><div class="default text">Select Country</div>
                    <div class="menu" tabindex="-1">
                <div class="item" data-value="af"><i class="af flag"></i>Afghanistan</div>
                ...
                <div class="item" data-value="zw"><i class="zw flag"></i>Zimbabwe</div>
              </div>

                  </div>
                </div>
              </div>
              <h4 class="ui dividing header">Billing Information</h4>
              <div class="field">
                <label>Card Type</label>
                <div class="ui selection dropdown" tabindex="0">
                  <input type="hidden" name="card[type]">
                  <div class="default text">Type</div>
                  <i class="dropdown icon"></i>
                  <div class="menu" tabindex="-1">
                    <div class="item" data-value="visa">
                      <i class="visa icon"></i>
                      Visa
                    </div>
                    <div class="item" data-value="amex">
                      <i class="amex icon"></i>
                      American Express
                    </div>
                    <div class="item" data-value="discover">
                      <i class="discover icon"></i>
                      Discover
                    </div>
                  </div>
                </div>
              </div>
              <div class="fields">
                <div class="seven wide field">
                  <label>Card Number</label>
                  <input type="text" name="card[number]" maxlength="16" placeholder="Card #">
                </div>
                <div class="three wide field">
                  <label>CVC</label>
                  <input type="text" name="card[cvc]" maxlength="3" placeholder="CVC">
                </div>
                <div class="six wide field">
                  <label>Expiration</label>
                  <div class="two fields">
                    <div class="field">
                      <div class="ui fluid search dropdown selection"><select name="card[expire-month]">
                        <option value="">Month</option>
                        <option value="1">January</option>
                        ...
                        <option value="12">December</option>
                      </select><i class="dropdown icon"></i><input class="search" autocomplete="off" tabindex="0"><div class="default text">Month</div><div class="menu" tabindex="-1"><div class="item" data-value="1">January</div>...</div></div>
                    </div>
                    <div class="field">
                      <input type="text" name="card[expire-year]" maxlength="4" placeholder="Year">
                    </div>
                  </div>
                </div>
              </div>

              <h4 class="ui dividing header">Receipt</h4>

              <div class="field">
                <label>Send Receipt To:</label>
                <div class="ui fluid multiple search selection dropdown">
                  <input type="hidden" name="receipt">
                  <i class="dropdown icon"></i>
                  <input class="search" autocomplete="off" tabindex="0"><span class="sizer"></span><div class="default text">Saved Contacts</div>
                  <div class="menu" tabindex="-1">
                    <div class="item" data-value="jenny" data-text="Jenny">
                      <img class="ui mini avatar image" src="/images/avatar/small/jenny.jpg">
                      Jenny Hess
                    </div>
                    ...
                    <div class="item" data-value="justen" data-text="Justen">
                      <img class="ui mini avatar image" src="/images/avatar/small/justen.jpg">
                      Justen Kitsune
                    </div>
                  </div>
                </div>
              </div>

              <div class="ui segment"> <-- 為可突然用上 segment??
                <div class="field">
                  <div class="ui toggle checkbox">
                    <input type="checkbox" name="gift" tabindex="0" class="hidden">
                    <label>Do not include a receipt in the package</label>
                  </div>
                </div>
              </div>
              <div class="ui button" tabindex="0">Submit Order</div>
            </form>

      - Form 的 state 有 `loading`、`success`、`error` 跟 `warning`；`loading` 會有個 loader 覆蓋在 form 上面 (半透明)，`success`/`error`/`warning` 主要是顯示 success/error/warning message；也就是輸出 HTML 不用控制要不要輸出對應的 block，從 form 的 class 就可以操控要顯示哪個 message box。
      - Form 的 `error` state，可以搭配 field 的 `error` state 一起使用，例如 `<div class="field error">`，會跟著 error message box 一起呈現紅色。

## Validation ??

  - [Form Validation \| Semantic UI](https://semantic-ui.com/behaviors/form.html) #ril

