//4.2 布局原理与约束（constraints）
/*
* 尺寸限制类容器用于限制容器大小，Flutter中提供了多种这样的容器，如ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio等
* Flutter 中有两种布局模型：
* 基于 RenderBox 的盒模型布局。
* 基于 Sliver(RenderSliver)按需加载列表布局
* 两种布局方式在细节上略有差异，但大体流程相同，布局流程如下：
* 1、上层组件向下层组件传递约束（constraints）条件。
* 2、下层组件确定自己的大小，然后告诉上层组件。注意下层组件的大小必须符合父组件的约束。
* 3、上层组件确定下层组件相对于自身的偏移和确定自身的大小（大多数情况下会根据子组件的大小来确定自身的大小）。
*
* 比如，父组件传递给子组件的约束是“最大宽高不能超过100，最小宽高为0”，如果我们给子组件设置宽高都为200，则子组件最终的大小是100*100，
* 因为任何时候子组件都必须先遵守父组件的约束，在此基础上再应用子组件约束（相当于父组件的约束和自身的大小求一个交集）
*
* */

// 4.2.1 BoxConstraints
/*
* BoxConstraints 是盒模型布局过程中父渲染对象传递给子渲染对象的约束信息，包含最大宽高信息，子组件大小需要在约束的范围内，
* BoxConstraints 默认的构造函数如下：
* const BoxConstraints({
  this.minWidth = 0.0, //最小宽度
  this.maxWidth = double.infinity, //最大宽度
  this.minHeight = 0.0, //最小高度
  this.maxHeight = double.infinity //最大高度
})
* 它包含 4 个属性，BoxConstraints还定义了一些便捷的构造函数，用于快速生成特定限制规则的BoxConstraints，
* 如BoxConstraints.tight(Size size)，它可以生成固定宽高的限制;
* BoxConstraints.expand()可以生成一个尽可能大的用以填充另一个容器的BoxConstraints
*
*
* */


//4.2.2 ConstrainedBox
/*
* ConstrainedBox用于对子组件添加额外的约束。
* 例如，如果你想让子组件的最小高度是80像素，你可以使用const BoxConstraints(minHeight: 80.0)作为子组件的约束。
*
*
* */



