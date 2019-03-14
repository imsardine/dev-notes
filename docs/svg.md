# SVG (Scalable Vector Graphics)

  - [Scalable Vector Graphics \- Wikipedia](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) #ril
      - Scalable Vector Graphics (SVG) is an XML-BASED VECTOR image format for TWO-DIMENSIONAL graphics with support for INTERACTIVITY and ANIMATION. The SVG specification is an open standard developed by the World Wide Web Consortium (W3C) since 1999. 不能表現 3D??
      - SVG images and their BEHAVIORS are defined in XML text files. This means that they can be SEARCHED, indexed, scripted, and compressed. As XML files, SVG images can be created and edited with any text editor, as well as with drawing software.

        最明顯的感受，SVG 上的文字是可以選取的。

      - All major modern web browsers—including Mozilla Firefox, Internet Explorer, Google Chrome, Opera, Safari, and Microsoft Edge—have SVG rendering support.

  - [SVG: Scalable Vector Graphics \| MDN](https://developer.mozilla.org/en-US/docs/Web/SVG) #ril

## HTML5 Canvas ?? {: #vs-html5-canvas }

  - [Canvas versus Scalable Vector Graphics (SVG) - Canvas element \- Wikipedia](https://en.wikipedia.org/wiki/Canvas_element#Canvas_versus_Scalable_Vector_Graphics_(SVG))
      - SVG is an earlier standard for drawing shapes in browsers. However, unlike canvas, which is raster-based (光柵), SVG is vector-based, so that each drawn shape is remembered as an OBJECT in a SCENE GRAPH?? or Document Object Model, which is subsequently rendered to a bitmap. This means that if attributes of an SVG object are changed, the browser can automatically RE-RENDER the scene. 這使得 SVG 很適合用來做有互動性的圖像 UI。
      - Canvas objects, on the other hand, are drawn in immediate mode. In the canvas example above, once the rectangle is drawn the model it was drawn from is FORGOTTEN by the system. If its position were to be changed, the ENTIRE SCENE would need to be redrawn, including any objects that might have been covered by the rectangle. But in the equivalent SVG case, one could simply change the position attributes of the rectangle and the browser would determine how to REPAINT it. 看似瀏覽器會自己做最佳化，沒什麼好擔心的?

        There are additional JavaScript libraries that add scene-graph capabilities to the canvas element. It is also possible to paint a canvas in layers and then recreate specific layers. 若真如此，SVG 在功能上會是 Canvas 的子集。

      - SVG images are represented in XML, and complex scenes can be created and maintained with XML editing tools.
      - The SVG scene graph enables EVENT HANDLERS to be associated with objects, so a rectangle may respond to an `onClick` event. To get the same functionality with canvas, one must MANUALLY match the coordinates of the mouse click with the coordinates of the drawn rectangle to determine whether it was clicked. 不過 JavaScript 應該有些 library 可以補 Canvas 的互動性?
      - Conceptually, canvas is a LOWER-LEVEL API upon which an engine, supporting for example SVG, might be built. There are JavaScript libraries that provide partial SVG implementations using canvas for browsers that do not provide SVG but support canvas, such as the browsers in Android 2.x. However, this is not normally the case—they are independent standards. The situation is complicated because there are scene graph libraries for canvas, and SVG has some bitmap manipulation functionality.

        如果 Canvas API 轉為低階，有些高階的應用採 SVG 好像也沒什麼不對，可以省下很多事 -- 可以回應事件、改 attibute 會自動重畫 ...

## 工具 {: #tools }

  - [Snap\.svg \- Home](http://snapsvg.io/) #ril

## 參考資料 {: #reference }

  - [W3C SVG Working Group](https://www.w3.org/Graphics/SVG/)

更多：

  - [Scripting](svg-scripting.md)

相關：

  - HTML5 Canvas
