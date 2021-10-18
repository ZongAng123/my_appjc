import 'package:flutter/material.dart';
//导入（ Import ）
//使用 import 关键字来访问在其它库中定义的 API。
import 'package:my_appjc/test.dart';

void main() {
  runApp(const MyApp());

   print('Hello, World!');

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '布局类组件'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //4.2.2 ConstrainedBox
  //ConstrainedBox用于对子组件添加额外的约束

  //我们先定义一个redBox，它是一个背景颜色为红色的盒子，不指定它的宽度和高度：
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  Widget zongangBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.orange)
  );

  Widget angBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.blue)
  );


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*
      * 在实际开发中，当我们发现已经使用 SizedBox 或 ConstrainedBox给子元素指定了固定宽高，但是仍然没有效果时，
      * 几乎可以断定：已经有父组件指定了约束！
      * 举个例子
      * 如 Material 组件库中的AppBar（导航栏）的右侧菜单中，我们使用SizedBox指定了 loading 按钮的大小
      * */
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          // SizedBox(
          //   width: 20,
          //   height: 20,
          //   child: CircularProgressIndicator(
          //     strokeWidth: 3,
          //     valueColor: AlwaysStoppedAnimation(Colors.white70),
          //   ),
          // )
        /**
         * 我们会发现右侧loading按钮大小并没有发生变化！这正是因为AppBar中已经指定了actions按钮的约束条件，
         * 所以我们要自定义loading按钮大小，就必须通过UnconstrainedBox来 “去除” 父元素的限制，代码如下：
         * **/
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          )
        //生效了！实际上将 UnconstrainedBox 换成 Center 或者 Align 也是可以的
        /**
         * 另外，需要注意，UnconstrainedBox虽然在其子组件布局时可以取消约束（子组件可以为无限大）,
         * 但是 UnconstrainedBox 自身是受其父组件约束的，所以当 UnconstrainedBox 随着其子组件变大后，
         * 如果UnconstrainedBox 的大小超过它父组件约束时，也会导致溢出报错,例子就不举了哈
         *
         * **/
        ],
      ),
      body: Center(

        child: Column(

          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You',
            ),
            ConstrainedBox( //我们实现一个最小高度为50，宽度尽可能大的红色容器。
                // constraints: BoxConstraints(
                //   minWidth: double.infinity, //宽度尽可能大
                //   minHeight: 50.0, //最小高度为50像素
                //  ),
              //上面代码等价于：
              constraints: BoxConstraints.tightFor(
                width: 200.0,
                height: 100.0,
              ),
              //而BoxConstraints.tightFor(width: 80.0,height: 80.0)等价于：

              child: Container(
               height: 5.0,
               child: redBox,
             ),
            ),
            //4.2.3 SizedBox
            //SizedBox用于给子元素指定固定的宽高，如：
            SizedBox(
              //实际上SizedBox只是ConstrainedBox的一个定制
              width: 80.0,
              height: 80.0,
              child: redBox,
            ),
          /**
           * 而实际上ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的，
           * 我们可以看到ConstrainedBox和SizedBox的createRenderObject()方法都返回的是一个RenderConstrainedBox对象：
           * @override
              RenderConstrainedBox createRenderObject(BuildContext context) {
              return RenderConstrainedBox(
              additionalConstraints: ...,
              );
              }
           *
           *
           * */
          //  4.2.4 多重限制
          //  如果某一个组件有多个父级ConstrainedBox限制，那么最终会是哪个生效？我们看一个例子：
            ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),//父
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),//子
                    child: zongangBox,
                ),
            ),
          //  4.2.5 UnconstrainedBox
          /**
           *  UnconstrainedBox
           *  虽然任何时候子组件都必须遵守其父组件的约束,但前提条件是它们必须是父子关系,假如有一个组件A,它的子组件是B,B的子组件是C
           *  则C必须遵守B的约束,同时B必须遵守A的约束,但是A的约束不会直接约束到C,除非B将A对它自己的约束透传给了C
           *  利用这个原理,就可以实现一个这样的B组件
           *  1、B 组件中在布局 C 时不约束C（可以为无限大）
           *  2、C 根据自身真实的空间占用来确定自身的大小
           *  3、B 在遵守 A 的约束前提下结合子组件的大小确定自身大小
           *
           *  而这个B组件就是UnconstrainedBox组件,也就是说UnconstrainedBox的子组件将不再受到约束,大小完全取决于自己.
           *  一般情况下，我们会很少直接使用此组件，但在"去除"多重限制的时候也许会有帮助，我们看下下面的代码：
           * */
           ConstrainedBox(constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0), //父
             child: UnconstrainedBox( //“去除”父级限制
                child: ConstrainedBox(
                  //如果没有中间的UnconstrainedBox，那么根据上面所述的多重限制规则，那么最终将显示一个90×100的红色框。
                  constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
                  //但是由于UnconstrainedBox “去除”了父ConstrainedBox的限制，则最终会按照子ConstrainedBox的限制来绘制redBox，即90×20：
                  child: angBox,
                ),
             ),
           ),
          /**
           * 请牢记，任何时候子组件都必须遵守其父组件的约束，所以在此提示读者，在定义一个通用的组件时，
           * 如果要对子组件指定约束，那么一定要注意，因为一旦指定约束条件，子组件自身就不能违反约束。
           * */
          //4.2.6 其它约束类容器
          /**
           * 4.2.6 其它约束类容器
           * 除了上面介绍的这些常用的尺寸限制类容器外，还有一些其他的尺寸限制类容器，
           * 比如AspectRatio，它可以指定子组件的长宽比、LimitedBox 用于指定最大宽高、
           * FractionallySizedBox可以根据父容器宽高的百分比来设置子组件宽高等，由于这些容器使用起来都比较简单，
           * 我们便不再赘述，读者可以自行了解。
           *
           * */
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
















