# HarmonyOsTab
HarmonyOsTab是一个封装了主页底部按钮和通用的指示器tab，优化了系统tab，支持指示器跟随手势滑动，支持自定义指示器，支持右侧添加按钮。

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab_24_10_01.png" width="120px" />
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab_24_10_02.png" width="120px" />
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab_24_10_03.png" width="120px" />
</p>

## 开发环境

DevEco Studio NEXT Developer Preview1,Build Version: 5.0.3.900

Api版本：**12**

modelVersion：5.0.0

## 快速使用

### 远程依赖方式使用

方式一：在Terminal窗口中，执行如下命令安装三方包，DevEco Studio会自动在工程的oh-package.json5中自动添加三方包依赖。

```
ohpm install @abner/tab
```

方式二：在工程的oh-package.json5中设置三方包依赖，配置示例如下：

```
"dependencies": { "@abner/tab": "^1.0.5"}
```

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab/tab_243_001.jpg" width="300"></p>

### 查看是否引用成功

无论使用哪种方式进行依赖，最终都会在使用的模块中，生成一个oh_modules文件，并创建源代码文件，有则成功，无则失败，如下：

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab/tab_243_003.jpg" width="300"></p>

## 基本使用

### 1、底部导航案例

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab/tab_243_004.jpg" width="200px" />
</p>

```typescript
/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例一，使用封装的BottomTabLayout，只需要page视图即可
 * */
@Entry
@Component
struct BottomTabPage1 {
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
      ActionBar({ title: "底部导航案例一" })

      BottomTabLayout({
        itemPage: this.itemPage, //tab对应的页面
        tabSelectedColor: "#D81E06", //文字选择颜色
        tabNormalColor: Color.Black, //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
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
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
      })
    }.height("100%")

  }
}

```

#### 相关属性

| 属性                  | 类型                          | 概述                 |
|---------------------|-----------------------------|--------------------|
| itemPage            | BuilderParam                | tab对应得页面           |
| tabSelectedColor    | ResourceColor               | tab选中颜色            |
| tabNormalColor      | ResourceColor               | tab未选中颜色           |
| tabSelectedBgColor  | ResourceColor               | 选中背景颜色             |
| tabNormalBgColor    | ResourceColor               | 未选中背景颜色            |
| tabIconWidth        | number                      | 图片icon的宽度，默认20     |
| tabIconHeight       | number                      | 图片icon的高度，默认20     |
| tabSize             | number                      | tab文字大小            |
| tabWeight           | number /FontWeight / string | 文字权重               |
| tabLabelMarginTop   | number                      | 标签距离图片的高度          |
| tabBar              | Array<TabBar>               | tab数据源             |
| tabWidth            | Length                      | tab指示器的宽度          |
| tabHeight           | number                      | tab指示器的高度，默认56     |
| currentIndex        | number                      | 当前索引，默认是第一个        |
| onChangePage        | 回调方法                        | 页面切换监听             |
| onTabBarClick       | tab点击回调                     | tab点击监听            |
| tabScrollable       | boolean                     | 是否可滑动，默认不可以滑动      |
| tabMarginBottom     | number                      | tab距离底部的距离         |
| isTabClickIntercept | boolean                     | tab点击拦截，默认false不拦截 |
| onDoubleClick       | 回调方法                        | 双击                 |

### 2、底部导航案例2，自定义Tab视图

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/tab/tab/tab_243_004.jpg" width="200px" />
</p>

```typescript
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
      })
    }
  }
}
```

#### 相关属性


| 属性                 | 类型                          | 概述               |
|--------------------|-----------------------------|------------------|
| itemPage           | BuilderParam                | tab对应得页面         |
| tabSelectedColor   | ResourceColor               | tab选中颜色          |
| tabNormalColor     | ResourceColor               | tab未选中颜色         |
| tabSelectedBgColor | ResourceColor               | 选中背景颜色           |
| tabNormalBgColor   | ResourceColor               | 未选中背景颜色          |
| tabIconWidth       | number                      | 图片icon的宽度，默认20   |
| tabIconHeight      | number                      | 图片icon的高度，默认20   |
| tabSize            | number                      | tab文字大小          |
| tabWeight          | number /FontWeight / string | 文字权重             |
| tabLabelMarginTop  | number                      | 标签距离图片的高度        |
| tabBar             | Array<TabBar>               | tab数据源           |
| tabWidth           | Length                      | tab指示器的宽度        |
| tabHeight          | number                      | tab指示器的高度，默认56   |
| currentIndex       | number                      | 当前索引，默认是第一个      |
| onChangePage       | 回调方法                        | 页面切换监听           |
| onTabBarClick      | tab点击回调                     | tab点击监听          |
| tabScrollable      | boolean                     | 是否可滑动，默认不可以滑动    |
| tabMarginBottom    | number                      | tab距离底部的距离       |
| isMarginBottom     | boolean                     | 默认开启，tab距离底部的距离  |
| isTabClickIntercept | boolean                     | tab点击拦截，默认false不拦截 |
| onDoubleClick       | 回调方法                        | 双击                 |


### 3、底部导航案例3，中间图片

```typescript
/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例中间图片
 * */
@Entry
@Component
struct BottomTabPage4 {
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
    if (index == 2) {
      Column() {
        Image($r("app.media.add"))
          .width(50).height(50)
          .margin({ top: -10 })
      }
    } else {
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

  build() {
    Column() {
      ActionBar({ title: "自定义底部导航(中间图片)" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        barBackgroundColor: "#e8e8e8",
        centerImageMarginBottom: 10,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("中间图片"),
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
      })
    }
  }
}
```


### 4、普通指示器导航【滑动】

#### 简单案例

```typescript
TabLayout({
  tabBar: ["条目一", "条目二"],
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

#### 设置圆角

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

#### 设置宽度

```typescript
TabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
            itemPage: this.itemPage,
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

#### 跟随文字宽度

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

#### 左侧按钮

```typescript
TabLayout({
            tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
            itemPage: this.itemPage,
            tabMenu: this.itemMenu, //按钮
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

#### 自定义下划线

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

#### 相关属性


| 属性                  | 类型                                             | 概述                |
|---------------------|------------------------------------------------|-------------------|
| tabWidth            | Length                                         | tab指示器的宽度         |
| tabHeight           | number                                         | tab指示器的高度         |
| onChangePage        | 回调方法(position: number)                         | 页面改变回调            |
| currentIndex        | number                                         | 当前索引，默认第0个        |
| tabScrollable       | boolean                                        | 是否可以滑动切换页面，默认可以滑动 |
| tabBar              | Array<string>                                  | 数据源               |
| itemPage            | 回调方法BuilderParam (index: number, item: string) | tab对应得页面          |
| tabAttribute        | 回调方法(attribute: TabModel)                      | 设置tab相关属性         |
| isHideDivider       | boolean                                        | 是否隐藏下划线，默认展示      |
| isTabAlignLeft      | boolean                                        | 是否从最左边开始，默认不是     |
| barMode             | BarMode                                        | 是均分还是可滑动，默认滑动     |
| onTabBarClick       | 回调方法(position: number)                         | tab点击回调           |
| isShowTabMenu       | boolean                                        | 是否展示右边的按钮选项，默认不展示 |
| tabMenu             | 回调方法BuilderParam                               | 右边展示的按钮视图         |
| tabMenuWidth        | number                                         | tab右侧按钮的宽度        |
| tabMenuMarginRight  | number                                         | tab按钮距离右侧的距离      |

### 5、普通指示器导航【不可滑动】

#### 简单案例

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

#### 均分

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

## 咨询作者

如果您在使用上有问题，解决不了，或者查看精华的鸿蒙技术文章，可扫码进行操作。

<p><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/abner.jpg" width="150"></p>

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
