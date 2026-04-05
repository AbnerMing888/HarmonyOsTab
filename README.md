# HarmonyOsTab

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/abner.jpg" width="100px" /><br/>
<span style="font-size:12px;color:red;">扫码关注，千帆起航，共筑鸿蒙！</span>
</p>

HarmonyOsTab是一个便捷的tabs组件，封装了底部tab和普通的指示器tab，支持多种效果展示，支持跟随手势滑动，几行代码便可轻松搞定！

对应的v2装饰器版本地址：[tab_v2](https://ohpm.openharmony.cn/#/cn/detail/@abner%2Ftab_v2)

## 静态效果

<p align="center">
<img src="https://loveharmony.oss-cn-beijing.aliyuncs.com/weight/tab/tab_001.png" width="700px"/>
</p>
<p align="center">
<img src="https://loveharmony.oss-cn-beijing.aliyuncs.com/weight/tab/tab_002.png" width="700px" />
</p>
<p align="center">
<img src="https://loveharmony.oss-cn-beijing.aliyuncs.com/weight/tab/tab_006.png" width="200px"/>
<img src="https://loveharmony.oss-cn-beijing.aliyuncs.com/weight/tab/tab_005.png" width="200px"/>
</p>

## 动态效果

<p align="center">
<img src="https://loveharmony.oss-cn-beijing.aliyuncs.com/weight/tab/tab_004.gif" width="300px" />
<img src="https://loveharmony.oss-cn-beijing.aliyuncs.com/weight/tab/tab_003.gif" width="300px" />
</p>

## 目前支持功能

- 0、支持自定义底部tab形式。
- 1、支持底部tab图文形式。
- 2、支持底部中间图片形式。
- 3、支持底部中间图片边框形式。
- 4、支持底部曲线动画效果形式。
- 5、支持底部圆角浮动形式。
- 6、支持指示器跟随手势滑动。
- 7、支持自定义指示器。
- 8、支持右侧添加按钮。
- 9、支持指示器图片形式。
- 10、支持点击和滑动拦截
- 11、支持底部tab背景模糊效果
- 12、支持底部tab移动背景效果
- 13、支持底部tab显示信息标记

## Api支持版本

Api版本：**>=12**

## 快速使用

### 远程依赖方式使用

方式一：在Terminal窗口中，执行如下命令安装三方包，DevEco Studio会自动在工程的oh-package.json5中自动添加三方包依赖。

```
ohpm install @abner/tab
```

方式二：在工程的oh-package.json5中设置三方包依赖，配置示例如下：

```
"dependencies": { "@abner/tab": "^1.1.5"}
```

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab/tab_243_001.jpg" width="300"></p>

### 查看是否引用成功

无论使用哪种方式进行依赖，最终都会在使用的模块中，生成一个oh_modules文件，并创建源代码文件，有则成功，无则失败，如下：

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab/tab_243_003.jpg" width="300"></p>


## 基本使用

### 1、底部导航案例一（使用封装好的）

```typescript
import { BottomTabLayout, TabBar } from '@abner/tab'
import { ActionBar } from '../../view/ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例一，使用封装的BottomTabLayout，只需要page视图即可
 * */

@Entry
@Component
struct BottomTabPage1 {
  tabsController: TabsController = new TabsController()
  @State tabBar: Array<TabBar> = [
    new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
    new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
    new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
    new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
  ]

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
      .onAppear(() => {
        console.log("============" + index)
      })
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例一" })

      BottomTabLayout({
        tabsController: this.tabsController,
        itemPage: this.itemPage, //tab对应的页面
        tabSelectedColor: "#D81E06", //文字选择颜色
        tabNormalColor: Color.Black, //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        onChangePage: (position) => {
          //页面切换
          console.log("===========页面切换:" + position)
        },
        onTabBarClick: (position) => {
          //tab点击
          console.log("===========单击:" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
        onTabAppear: () => {
          this.tabsController.preloadItems([1])
        },
        tabBar: this.tabBar
      }).layoutWeight(1)

    }.height("100%")
      .backgroundColor($r("app.color.home_select_color"))

  }
}

```

#### 相关属性

| 属性                        | 类型                            | 概述                                  |
|---------------------------|-------------------------------|-------------------------------------|
| itemPage                  | BuilderParam                  | tab对应得页面                            |
| tabSelectedColor          | ResourceColor                 | tab选中颜色                             |
| tabNormalColor            | ResourceColor                 | tab未选中颜色                            |
| tabSelectedBgColor        | ResourceColor                 | 选中背景颜色                              |
| tabNormalBgColor          | ResourceColor                 | 未选中背景颜色                             |
| tabIconWidth              | number                        | 图片icon的宽度，默认20                      |
| tabIconHeight             | number                        | 图片icon的高度，默认20                      |
| tabSize                   | number                        | tab文字大小                             |
| tabWeight                 | number /FontWeight / string   | 文字权重                                |
| tabLabelMarginTop         | number                        | 标签距离图片的高度                           |
| tabBar                    | Array<TabBar>                 | tab数据源                              |
| tabWidth                  | Length                        | tab指示器的宽度                           |
| tabHeight                 | number                        | tab指示器的高度，默认56                      |
| currentIndex              | number                        | 当前索引，默认是第一个                         |
| onChangePage              | 回调方法                          | 页面切换监听                              |
| onTabBarClick             | tab点击回调                       | tab点击监听                             |
| tabScrollable             | boolean                       | 是否可滑动，默认不可以滑动                       |
| tabMarginBottom           | number                        | tab距离底部的距离                          |
| isTabClickIntercept       | boolean                       | tab点击拦截，默认false不拦截                  |
| onDoubleClick             | 回调方法                          | 双击                                  |
| tabPositionInterceptArray | Array                         | 按照索引拦截，具体传递对应索引即可                   |
| barBackgroundColor        | ResourceColor                 | tabBar的背景颜色                         |
| navBarBackgroundColor     | ResourceColor                 | 底部导航栏背景颜色                           |
| tabBarController          | TabBarController              | 用于动态改变标题的控制器                        |
| tabsController            | TabsController                | tabs组件控制器                           |
| bottomTabType             | BottomTabType                 | 设置底部导航模式，默认为普通模式                    |
| bottomTabBorderOptions    | BorderOptions                 | 设置底部导航边框样式                          |
| bottomTabMargin           | Margin/Length/LocalizedMargin | 距离底部的距离                             |
| barBorder                 | BorderOptions                 | 设置tabBar底部边框样式                      |
| barBackgroundEffect       | BackgroundEffectOptions       | 设置TabBar背景属性，包含背景模糊半径，亮度，饱和度，颜色等参数。 |
| onTabAppear               | () => void                    | 当组件首次渲染完成并出现在可视区域时触发                |
| onTabAttach               | () => void                    | 当组件被挂载到组件树时触发（早于渲染）                 |
| onTabDisAppear            | () => void                    | 当组件离开可视区域时触发（如页面跳转、Tab切换）           |
| onTabDetach               | () => void                    | 当组件从组件树中卸载时触发。                      |

### 2、底部导航案例2，自定义Tab视图


```typescript
import { BaseBottomTabLayout, TabBar } from '@abner/tab'
import { ActionBar } from '../../view/ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例二，使用BaseBottomTabLayout，可以自定义Tab视图
 * */
@Entry
@Component
struct BottomTabPage2 {
  private currentIndex = 0 //默认是第一个

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义Tab视图，自己绘制
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    Column() {
      Image(this.currentIndex == index ? item.selectedIcon
        : item.normalIcon)
        .width(30).height(30)
      Text(item.title)
        .fontColor(this.currentIndex == index ? "#D81E06" : "#000000")
        .fontSize(14)
        .margin({ top: 5 })
    }.width("100%")
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例二" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
        onTabBarClick: (position) => {
          //tab点击
          console.log("====点击了Tab" + position)
        },
        onChangePage: (position) => {
          //页面切换
          console.log("====页面切换了" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
      }).layoutWeight(1)
    }.width("100%")
      .height("100%")
      .backgroundColor($r("app.color.home_select_color"))
  }
}
```

#### 相关属性

同案例一属性一致。

### 3、底部导航案例3，纯文字导航

```typescript
import { BaseBottomTabLayout, TabBar } from '@abner/tab'
import { ActionBar } from '../../view/ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例三，和案例二一样，只不过是纯文字
 * */
@Entry
@Component
struct BottomTabPage3 {
  @State currentIndex: number = 0

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:导航页面
   * */
  @Builder
  itemPage(index: number) {
    Text("页面" + index)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:导航
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    Text(item.title)
      .fontColor(this.currentIndex == index ? Color.Red : Color.Black)

  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例三" })
      BaseBottomTabLayout({
        tabBar: [
          new TabBar("首页"),
          new TabBar("网络"),
          new TabBar("列表"),
          new TabBar("组件")
        ],
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
        onTabBarClick: (position) => {
          //点击tab
          console.log("==========点击了：" + position)
        },
        onChangePage: (position) => {
          this.currentIndex = position
        }
      }).layoutWeight(1)
    }.width("100%")
      .height("100%")
      .backgroundColor($r("app.color.home_select_color"))
  }
}
```

#### 相关属性

同案例一属性一致。

### 4、底部导航案例中间图片

```typescript
import { BaseBottomTabLayout, BottomTabType, TabBar } from '@abner/tab'
import { ActionBar } from '../../view/ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例中间图片
 * */
@Entry
@Component
struct BottomTabPage4 {
  private currentIndex = 0 //默认是第一个
  @State tabCurrentIndex: number = 0 //默认选中第0个

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Column() {
      Text(item.title)
    }.width("100%")
      .height("100%")
      .justifyContent(FlexAlign.Center)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义Tab视图，自己绘制
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    if (index != 2) {
      Column() {
        Column() {
          Image(this.currentIndex == index ? item.selectedIcon
            : item.normalIcon)
            .width(30).height(30)
          Text(item.title)
            .fontColor(this.currentIndex == index ? "#D81E06" : "#000000")
            .fontSize(14)
            .margin({ top: 5 })
        }
      }.width("100%")
        .justifyContent(FlexAlign.Center)
    }
  }

  @Builder
  itemCenterTab() {
    Image($r("app.media.add"))
      .width(50)
      .height(50)
      .onClick(() => {
        this.tabCurrentIndex = 2
      })
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航(中间图片)" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        itemCenterTab: () => {
          this.itemCenterTab()
        },
        currentIndex: this.tabCurrentIndex,
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        bottomTabType: BottomTabType.CENTER_IMAGE, //中间图片
        centerImageMarginTop: 25, //中间图片距离顶部的距离，这里距离底部为组件高度的一半
        tabMarginBottom: 30,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("中间图片"),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
        onTabBarClick: (position) => {
          //tab点击
          console.log("====点击了Tab" + position)
          this.tabCurrentIndex = position
        },
        onChangePage: (position) => {
          //页面切换
          console.log("====页面切换了" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
      }).layoutWeight(1)
    }.width("100%")
      .height("100%")
      .backgroundColor($r("app.color.home_select_color"))
  }
}

```

#### 相关属性

同案例一属性一致。

### 5、底部导航案例中间图片+边框线

```typescript
import { BaseBottomTabLayout, BottomTabType, TabBar } from '@abner/tab'
import { ActionBar } from '../../view/ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2026/2/7
 * INTRODUCE:底部导航案例中间图片+边框线
 * */
@Entry
@Component
struct BottomTabPage6 {
  private currentIndex = 0 //默认是第一个
  @State tabCurrentIndex: number = 0 //默认选中第0个

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Column() {
      Text(item.title)
    }.width("100%")
      .height("100%")
      .justifyContent(FlexAlign.Center)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义Tab视图，自己绘制
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    if (index != 2) {
      Column() {
        Column() {
          Image(this.currentIndex == index ? item.selectedIcon
            : item.normalIcon)
            .width(30).height(30)
          Text(item.title)
            .fontColor(this.currentIndex == index ? "#D81E06" : "#000000")
            .fontSize(14)
            .margin({ top: 5 })
        }
      }.width("100%")
        .justifyContent(FlexAlign.Center)
    }
  }

  @Builder
  itemCenterTab() {
    Image($r("app.media.add"))
      .width(50)
      .height(50)
      .onClick(() => {
        this.tabCurrentIndex = 2
      })
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航(中间图片+边框)" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        itemCenterTab: () => {
          this.itemCenterTab()
        },
        currentIndex: this.tabCurrentIndex,
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        bottomTabType: BottomTabType.CENTER_IMAGE, //中间图片
        centerImageMarginTop: 26, //中间图片距离顶部的距离，这里距离底部为组件高度的一半
        centerImageStroke: "#999999", //边框线
        tabMarginBottom: 30,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("中间图片"),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
        onTabBarClick: (position) => {
          //tab点击
          console.log("====点击了Tab" + position)
          this.tabCurrentIndex = position
        },
        onChangePage: (position) => {
          //页面切换
          console.log("====页面切换了" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
      }).layoutWeight(1)
    }.width("100%")
      .height("100%")
      .backgroundColor($r("app.color.home_select_color"))
  }
}
```

#### 相关属性

同案例一属性一致。

### 6、底部导航(中间图片+曲线)

```typescript
import { BaseBottomTabLayout, BottomTabType, TabBar } from '@abner/tab'
import { ActionBar } from '../../view/ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2026/2/7
 * INTRODUCE:底部导航案例中间图片+边框线(交汇处曲线形式)
 * */
@Entry
@Component
struct BottomTabPage7 {
  private currentIndex = 0 //默认是第一个
  @State tabCurrentIndex: number = 0 //默认选中第0个

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Column() {
      Text(item.title)
    }.width("100%")
      .height("100%")
      .justifyContent(FlexAlign.Center)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义Tab视图，自己绘制
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    if (index != 2) {
      Column() {
        Column() {
          Image(this.currentIndex == index ? item.selectedIcon
            : item.normalIcon)
            .width(30).height(30)
          Text(item.title)
            .fontColor(this.currentIndex == index ? "#D81E06" : "#000000")
            .fontSize(14)
            .margin({ top: 5 })
        }
      }.width("100%")
        .justifyContent(FlexAlign.Center)
    }
  }

  @Builder
  itemCenterTab() {
    Image($r("app.media.add"))
      .width(50)
      .height(50)
      .onClick(() => {
        this.tabCurrentIndex = 2
      })
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航(中间图片+曲线)" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        itemCenterTab: () => {
          this.itemCenterTab()
        },
        currentIndex: this.tabCurrentIndex,
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        bottomTabType: BottomTabType.CENTER_IMAGE, //中间图片
        centerImageMarginTop: 30, //中间图片距离顶部的距离，这里距离底部为组件高度的一半
        centerImageStroke: "#999999", //边框线
        centerImageFill: Color.White, //边框线
        isCenterImageCurve: true, //曲线
        tabMarginBottom: 30,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("中间图片"),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
        onTabBarClick: (position) => {
          //tab点击
          console.log("====点击了Tab" + position)
          this.tabCurrentIndex = position
        },
        onChangePage: (position) => {
          //页面切换
          console.log("====页面切换了" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
      }).layoutWeight(1)
    }.width("100%")
      .height("100%")
      .backgroundColor($r("app.color.home_select_color"))
  }
}
```

#### 相关属性

同案例一属性一致。

### 7、底部圆角导航

```typescript
import { BottomTabLayout, BottomTabType, TabBar } from '@abner/tab'
import { ActionBar } from '../../view/ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/9/8
 * INTRODUCE:底部圆角导航
 * */

@Entry
@Component
struct BottomTabPage5 {
  tabsController: TabsController = new TabsController()
  @State tabBar: Array<TabBar> = [
    new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
    new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
    new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
    new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
  ]

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
      .width("100%")
      .height("100%")
      .textAlign(TextAlign.Center)
      .backgroundColor("#E8E8E8")
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例五" })

      BottomTabLayout({
        tabsController: this.tabsController,
        itemPage: this.itemPage, //tab对应的页面
        tabSelectedColor: "#D81E06", //文字选择颜色
        tabNormalColor: Color.Black, //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        bottomTabType: BottomTabType.ROUNDED, //底部圆角导航
        bottomTabMargin: { bottom: 40, left: "5%" },
        tabWidth: "90%",
        bottomTabBorderOptions: { radius: 30 },
        barBackgroundColor: Color.White,
        onChangePage: (position) => {
          //页面切换
          console.log("===========页面切换:" + position)
        },
        onTabBarClick: (position) => {
          //tab点击
          console.log("===========单击:" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
        onTabAppear: () => {
          this.tabsController.preloadItems([1, 2])
        },
        tabBar: this.tabBar
      }).layoutWeight(1)
    }.height("100%")

  }
}
```

#### 相关属性

同案例一属性一致。

### 8、底部曲线动画导航

```typescript
import { BaseBottomTabLayout, BottomTabCurve, BottomTabType, TabBar } from '@abner/tab'
import { ActionBar } from '../../view/ActionBar'

/**
 * AUTHOR:AbnerMing
 * DATE:2026/2/7
 * INTRODUCE:底部曲线导航
 * */
@Entry
@Component
struct BottomTabPage8 {
  private tempColorArray: ResourceColor[] = ["#ffcc80", "#ff9323ac", "#ff26a965", "#ff93d923", "#ff11c5de",]
  @State selectIndex: number = 0
  private tabArray: Resource[] =
    [$r('sys.symbol.house_fill'), $r('sys.symbol.square_fill_grid_2x2'), $r('sys.symbol.bell_fill'),
      $r('sys.symbol.externaldrive_fill'), $r('sys.symbol.person_2_fill')]

  @Builder
  tabView(position: number) {
    if (this.selectIndex == position) {
      Column() {
        SymbolGlyph(this.tabArray[position])
          .fontSize(20)
          .renderingStrategy(SymbolRenderingStrategy.SINGLE)
          .fontColor([Color.Black])
      }
      .backgroundColor(Color.White)
      .width(35)
      .height(35)
      .borderRadius(35)
      .justifyContent(FlexAlign.Center)
    } else {
      SymbolGlyph(this.tabArray[position])
        .fontSize(20)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Gray])
    }

  }

  @Builder
  pageView(position: number) {
    Column() {
      Text(position.toString())
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.tempColorArray[position])
  }

  build() {
    RelativeContainer() {
      BottomTabCurve({
        navigationSize: 5, //tab数量
        onPageChange: (position: number) => {
          this.selectIndex = position
        },
        tabView: (position: number) => {
          this.tabView(position)
        },
        pageView: (position: number) => {
          this.pageView(position)
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}
```

### 9、底部tab信息标记

```typescript
import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { BottomTabLayout, TabBar } from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例，使用封装的BottomTabLayout，只需要page视图即可,+badge
 * */

@RouterPath("home_tabBottomTabPage9")
@Component
export struct V1BottomTabPage9 {
  tabsController: TabsController = new TabsController()
  @State tabBar: Array<TabBar> = [
    new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
    new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
    new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
    new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
  ]

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
  }

  build() {
    Column() {
      TitleBar({ title: "底部导航信息标记", isAvoidanceNavigation: true })
      BottomTabLayout({
        tabsController: this.tabsController,
        badgeText: "1",
        badgeShowPosition: [3],
        itemPage: this.itemPage, //tab对应的页面
        tabSelectedColor: "#D81E06", //文字选择颜色
        tabNormalColor: Color.Black, //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        barBackgroundColor: Color.White,
        navBarBackgroundColor: Color.White,
        onChangePage: (position) => {
          //页面切换
          console.log("===========页面切换:" + position)
        },
        onTabBarClick: (position) => {
          //tab点击
          console.log("===========单击:" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
        onTabAppear: () => {
          this.tabsController.preloadItems([1])
        },
        tabBar: this.tabBar
      }).layoutWeight(1)

    }.height("100%")
    .backgroundColor($r("app.color.home_select_color"))

  }
}
```

### 10、底部tab背景效果

```typescript
import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { BottomTabLayout, BottomTabType, TabBar } from '@abner/tab'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/9/8
 * INTRODUCE:底部圆角导航，以背景方式滑动
 * */
@RouterPath("home_tabBottomTabPage11")
@Component
export struct V1BottomTabPage11 {
  tabsController: TabsController = new TabsController()
  @State tabBar: Array<TabBar> = [
    new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
    new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
    new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
    new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
  ]

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab对应的页面
   * @param index 索引
   * @param item TabBar对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
      .width("100%")
      .height("100%")
      .textAlign(TextAlign.Center)
      .backgroundColor("#E8E8E8")
  }

  build() {
    Column() {
      TitleBar({ title: "底部导航案例(圆角形式背景)" })

      BottomTabLayout({
        tabsController: this.tabsController,
        itemPage: this.itemPage, //tab对应的页面
        tabSelectedColor: "#D81E06", //文字选择颜色
        tabNormalColor: Color.Black, //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        bottomTabType: BottomTabType.ROUNDED, //底部圆角导航
        bottomTabMargin: { bottom: 40, left: "5%" },
        tabWidth: "90%",
        bottomTabBorderOptions: { radius: 30 },
        barBackgroundColor: Color.White,
        isSlidBackground: true,//需要背景
        onChangePage: (position) => {
          //页面切换
          console.log("===========页面切换:" + position)
        },
        onTabBarClick: (position) => {
          //tab点击
          console.log("===========单击:" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
        onTabAppear: () => {
          this.tabsController.preloadItems([1, 2])
        },
        tabBar: this.tabBar
      }).layoutWeight(1)
    }.height("100%")

  }
}
```

#### 相关属性

同案例一属性一致。


## 横向tab滑动案例

案例对应文件为：TabLayoutScrollPage.ets

### 1、简单使用

```typescript
TabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
  itemPage: this.itemPage,
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

### 2、修改下划线样式

```typescript
TabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
            itemPage: this.itemPage,
            tabAttribute: (tab) => {
              tab.tabDividerStrokeWidth = 10
              tab.tabDividerLineCapStyle = LineCapStyle.Round
            },
            onChangePage: (position) => {
              //页面改变
              console.log("===页面改变:" + position)
            },
            onTabBarClick: (position) => {
              //点击改变
              console.log("===点击改变:" + position)
            }
          })
```


### 3、修改下划线颜色

```typescript
TabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
  itemPage: this.itemPage,
  tabAttribute: (tab) => {
    tab.tabSelectedColor = Color.Red
    tab.tabDividerColor = Color.Red
  },
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

### 4、跟随文字的宽度

```typescript
TabLayout({
  tabBar: ["一", "第二", "条目三", "是条目四", "我是条目五", "最后是条目六"],
  itemPage: this.itemPage,
  tabAttribute: (tab) => {
    tab.tabItemWidth = undefined
    tab.tabItemMargin = { left: 10, right: 10 }
    //更改下划线的宽度
    tab.tabDividerWidth = undefined
  },
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

### 5、下划线设置固定宽度

```typescript
TabLayout({
  tabBar: ["一", "第二", "条目三", "是条目四", "我是条目五", "最后是条目六"],
  itemPage: this.itemPage,
  tabAttribute: (tab) => {
    tab.tabItemWidth = undefined
    tab.tabItemMargin = { left: 10, right: 10 }
    //更改下划线的宽度
    tab.tabDividerWidth = 10
  },
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

### 6、居中，固定下划线

```typescript
TabLayout({
  tabBar: ["条目一", "条目二"],
  itemPage: this.itemPage,
  tabType: TabType.SCROLL_CENTER,
  tabAttribute: (tab) => {
    tab.tabDividerWidth = 20
    tab.tabItemWidth = 200
  },
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

### 7、自定义下划线

```typescript
BaseTabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
  itemPage: this.itemPage,
  tabModel: {
    tabDividerStrokeWidth: 15
  },
  itemTabIndicator: () => {
    this.tabItemTabIndicator(this) //自己定义指示器
  },
  itemTab: (index: number, item: string) => {
    this.tabItem(this, index, item)
  },
})
```

### 8、右侧按钮

```typescript
 TabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六", "条目七", "条目八"],
  itemPage: this.itemPage,
  tabMenu: this.tabRightMenu, //按钮
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

### 9、左侧按钮

```typescript
TabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六", "条目七", "条目八"],
            itemPage: this.itemPage,
            tabLeftMenu: this.tabLeftMenu, //按钮
            tabAttribute: (tab) => {
              tab.tabDividerWidth = 20
            },
            onChangePage: (position) => {
              //页面改变
              console.log("===页面改变:" + position)
            },
            onTabBarClick: (position) => {
              //点击改变
              console.log("===点击改变:" + position)
            }
          })
```

### 10、左右按钮

```typescript
TabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六", "条目七", "条目八"],
            itemPage: this.itemPage,
            tabAttribute: (tab) => {
              tab.tabDividerWidth = 20
            },
            tabLeftMenu: this.tabLeftMenu, //左侧按钮
            tabMenu: this.tabRightMenu, //右侧按钮
            onChangePage: (position) => {
              //页面改变
              console.log("===页面改变:" + position)
            },
            onTabBarClick: (position) => {
              //点击改变
              console.log("===点击改变:" + position)
            }
          })
```

#### 相关属性

| 属性                  | 类型                                             | 概述                           |
|---------------------|------------------------------------------------|------------------------------|
| tabWidth            | Length                                         | tab指示器的宽度                    |
| tabHeight           | number                                         | tab指示器的高度                    |
| onChangePage        | 回调方法(position: number)                         | 页面改变回调                       |
| currentIndex        | number                                         | 当前索引，默认第0个                   |
| tabScrollable       | boolean                                        | 是否可以滑动切换页面，默认可以滑动            |
| tabBar              | Array<string>                                  | 数据源                          |
| itemPage            | 回调方法BuilderParam (index: number, item: string) | tab对应得页面                     |
| tabAttribute        | 回调方法(attribute: TabModel)                      | 设置tab相关属性                    |
| isHideDivider       | boolean                                        | 是否隐藏下划线，默认展示                 |
| isTabAlignLeft      | boolean                                        | 是否从最左边开始，默认不是                |
| barMode             | BarMode                                        | 是均分还是可滑动，默认滑动                |
| onTabBarClick       | 回调方法(position: number)                         | tab点击回调                      |
| isShowTabMenu       | boolean                                        | 是否展示右边的按钮选项，默认不展示            |
| tabMenu             | 回调方法BuilderParam                               | 右边展示的按钮视图                    |
| tabLeftMenu         | 回调方法BuilderParam                               | 左侧按钮                         |
| tabMenuWidth        | number                                         | tab右侧按钮的宽度                   |
| tabMenuMarginRight  | number                                         | tab按钮距离右侧的距离                 |
| isTabClickIntercept | boolean                                        | 是否拦截点击和滑动                    |
| isVertical          | boolean                                        | 是否设置为纵向                      |
| tabType             | TabType                                        | tab类型，默认是可滑动类型TabType.SCROLL |
| barBackgroundColor  | ResourceColor                                  | 背景颜色                         |
| tabIndicatorBorder  | BorderOptions                                  | tab指示器边框样式                   |

## 普通指示器导航【不可滑动】

更多案例，可见文件TabLayoutPage.ets

#### 1、简单案例

```typescript
TabLayout({
        tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
        itemPage: this.itemPage,
        tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
        onChangePage: (position) => {
          //页面改变
          console.log("===页面改变:" + position)
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("===点击改变:" + position)
        }
      })
```

#### 2、均分

```typescript
TabLayout({
        tabBar: ["条目一", "条目二"],
        barMode: BarMode.Fixed, //均分
        tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
        itemPage: this.itemPage,
        onChangePage: (position) => {
          //页面改变
          console.log("===页面改变:" + position)
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("===点击改变:" + position)
        }
      })
```

## License

```
Copyright (C) AbnerMing, HarmonyOsTab Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
