---
title: Semantic UI / Layout
---
# [Semantic UI](semantic-ui.md) / Layout

  - [Layouts \| Semantic UI](https://semantic-ui.com/usage/layout.html) 下面 Pages 示範 Homepage、Sticky Menus、Fixed Menu、Login Form 等，用來自訂 Static Site Generator (SSG) 的樣板一定很有質感!! #ril

## Divider, Segment ??

  - [Divider \| Semantic UI](https://semantic-ui.com/elements/divider.html) #ril
      - A divider visually segments content into groups

        不一定要搭配 segment 使用，但通常會用來劃分某塊區域，而這個區域通常是 segment。

    Divider

      - A standard divider

            <div class="html ui top attached segment">
              <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
              <div class="ui divider"></div>
              <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
              <div class="ui top attached label">Example <i data-content="Copy code" class="copy link icon"></i></div>
            </div>

      - `<div class="ui divider"></div>` 的表現方式就是個細長的 `<div>` (高度為 0，但兩側有 `1px` 的 border，及一些 margin)；幾乎取代了 `<hr>`；跟下面的 horizontal divider 好像沒有不同?
      - To add a divider between parts of a grid use a `divided grid` variation. ??

    Vertical Divider

      - A divider can segment content vertically

            <div class="ui segment">
              <div class="ui two column very relaxed grid">
                <div class="column">
                  <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
                  <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
                  <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
                  <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
                </div>
                <div class="column">
                  <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
                  <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
                  <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
                  <img class="ui wireframe image" src="/images/wireframe/short-paragraph.png">
                </div>
              </div>
              <div class="ui vertical divider">
                and
              </div>
            </div>

        HTML source 跟 UI 上呈現的順序沒有對應關係，跟上面 "To add a divider between parts of a grid use a `divided grid` variation." 可能有關? 結果上是 segment > grid > columns，然後 segment 再加上 vertical divider。幾個範例觀察下來，divider 只會直接加在 segment 底下，不會是在 grid 裡面。

      - Vertical dividers requires `position: relative` on the element that you would like to contain the divider 但上面並沒有看到??

        Due to a change in W3C implementation of [absolutely positioned elements in flex containers](https://github.com/w3c/csswg-drafts/issues/401) vertical dividers now currently only support 50/50 splits automatically, and only if not positioned as direct children of FLEX?? containers (like grid).

      - A vertical divider will automatically swap to a horizontal divider at mobile resolutions when used inside a STACKABLE grid 很貼心的設計

            <div class="ui placeholder segment">
              <div class="ui two column very relaxed stackable grid">
                <div class="column">
                  <div class="ui form">
                    <div class="field">
                      <label>Username</label>
                      <div class="ui left icon input">
                        <input type="text" placeholder="Username">
                        <i class="user icon"></i>
                      </div>
                    </div>
                    <div class="field">
                      <label>Password</label>
                      <div class="ui left icon input">
                        <input type="password">
                        <i class="lock icon"></i>
                      </div>
                    </div>
                    <div class="ui blue submit button">Login</div>
                  </div>
                </div>
                <div class="middle aligned column">
                  <div class="ui big button">
                    <i class="signup icon"></i>
                    Sign Up
                  </div>
                </div>
              </div>
              <div class="ui vertical divider">
                Or
              </div>
            </div>

    Horizontal Divider

      - A divider can segment content horizontally

            <div class="ui center aligned basic segment">
              <div class="ui left icon action input">
                <i class="search icon"></i>
                <input type="text" placeholder="Order #">
                <div class="ui blue submit button">Search</div>
              </div>
              <div class="ui horizontal divider">
                Or
              </div>
              <div class="ui teal labeled icon button">
                Create New Order
                <i class="add icon"></i>
              </div>
            </div>

      - Horizontal dividers can also be used in combination with HEADERS and icons to create different styles of dividers.

            <div class="another example">
              <i class="fitted icon code"></i><h4 class="ui horizontal divider header">
                <i class="tag icon"></i>
                Description
              </h4><a class="anchor" id=""></a>
              <p>Doggie treats are good for all times of the year. Proven to be eaten by 99.9% of all dogs worldwide.</p>
              <h4 class="ui horizontal divider header">
                <i class="bar chart icon"></i>
                Specifications
              </h4>
              <table class="ui definition table">
                <tbody>
                  <tr>
                    <td class="two wide column">Size</td>
                    <td>1" x 2"</td>
                  </tr>
                  <tr>
                    <td>Weight</td>
                    <td>6 ounces</td>
                  </tr>
                  <tr>
                    <td>Color</td>
                    <td>Yellowish</td>
                  </tr>
                  <tr>
                    <td>Odor</td>
                    <td>Not Much Usually</td>
                  </tr>
                </tbody>
              </table>
            </div>

        直接用 `<h1>` ~ `<h6>` 來當分隔線的內容，剛好要安排文件結構 (不單單只是視覺上的效果時) 時可以這麼做。

      - Dividers will automatically vary the size of their dividing rules to match the length of your text

  - [Segment \| Semantic UI](https://semantic-ui.com/elements/segment.html) #ril

## Tab ??

  - [Definition - Tab \| Semantic UI](https://semantic-ui.com/modules/tab.html) #ril
      - A tab is a HIDDEN SECTION of content activated by a MENU. 這直接反應在實作細節上 -- `ui menu` + `ui tab segment`。

            <div class="ui top attached tabular menu">
              <div class="item">Tab</div>
            </div>
            <div class="ui bottom attached tab segment">
              <p></p>
              <p></p>
            </div>

        這意謂著 tab 的細節可以看 menu，可以做出更多變化；所謂 tab 就是 menu + segment 組合的概念而已。

      - A tab is hidden by default, and will only become visible when given the class name `active` or when activated with Javascript.

            <div class="ui top attached tabular menu">
              <div class="active item">Tab</div>
            </div>
            <div class="ui bottom attached active tab segment">
              <p></p>
              <p></p>
            </div>

        `ui menu` 跟 `ui tab segment` 兩邊要搭配好 -- item 配某個 tab 的內容

## Grid ??

  - [Grid \| Semantic UI](https://semantic-ui.com/collections/grid.html) 雖然是 collection，但比較像是 layout；事實上 Layouts 文件裡也提到了 Grid #ril

