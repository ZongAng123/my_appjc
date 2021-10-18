# 4.2 布局原理与约束（constraints）

尺寸限制类容器用于限制容器大小，Flutter中提供了多种这样的容器，如ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio 等，本节将介绍一些常用的。

## Flutter 中有两种布局模型：

1、基于 RenderBox 的盒模型布局。

2、基于 Sliver ( RenderSliver ) 按需加载列表布局。
