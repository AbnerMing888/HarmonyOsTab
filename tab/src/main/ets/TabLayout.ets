import { BaseTabLayout } from './BaseTabLayout'
import { TabModel } from './TabModel'
import { HashMap } from '@kit.ArkTS'
import { TabType } from './TabType'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/20
 * INTRODUCE:自定义TabLayout
 * */
@Component
export struct TabLayout {
  tabWidth: Length = '100%' //tab指示器的宽度
  tabHeight: number = 56 //tab指示器的高度
  onChangePage?: (position: number) => void
  @Prop currentIndex: number = 0 //默认选中第0个
  @Prop tabScrollable: boolean = true //默认可以滑动
  @Prop tabBar: Array<string> = []
  @BuilderParam itemPage: (index: number, item: string) => void //tab对应得页面
  private tabModel: TabModel = new TabModel() //数据模型
  tabAttribute?: (attribute: TabModel) => void //tab相关属性
  isHideDivider: boolean = false //是否隐藏下划线，默认展示
  isTabAlignLeft: boolean = false //是否从最左边开始
  barMode: BarMode = BarMode.Scrollable //默认滑动
  onTabBarClick?: (position: number) => void
  isShowTabMenu: boolean = false //是否展示右边的按钮选项
  @BuilderParam tabMenu?: () => void
  @BuilderParam tabLeftMenu?: () => void //左侧按钮
  tabMenuWidth: number = 0 //tab右侧按钮的宽度
  tabMenuMarginRight: number = 0 //tab按钮距离右侧的距离
  private tabTextWidthMap?: HashMap<string, Length> = new HashMap()
  @State isShowText: boolean = false
  tabType: TabType = TabType.SCROLL
  barBackgroundColor?: ResourceColor = Color.Transparent
  tabIndicatorBorder?: BorderOptions //tab指示器边框样式
  alignItems?: HorizontalAlign = HorizontalAlign.Center
  @Prop isTabClickIntercept?: boolean = false //tab点击拦截

  aboutToAppear() {
    if (this.tabAttribute != null) {
      this.tabAttribute(this.tabModel)
    }
  }

  @Builder
  tabItemTabIndicator(_this: TabLayout) {
    Divider()
      .lineCap(_this.tabModel.tabDividerLineCapStyle)
      .strokeWidth(_this.tabModel.tabDividerStrokeWidth)
      .color(_this.tabModel.tabDividerColor)
      .width(_this.tabModel.tabDividerWidth)
  }

  @Builder
  tabItem(_this: TabLayout, index: number, item: string) {
    Column() {
      Text(item)
        .fontColor(_this.currentIndex === index ? _this.tabModel.tabSelectedColor : _this.tabModel.tabNormalColor)
        .fontSize(_this.currentIndex === index ? _this.tabModel.tabSelectedSize : _this.tabModel.tabNormalSize)
        .fontWeight(_this.currentIndex === index ? _this.tabModel.tabSelectedWeight : _this.tabModel.tabNormalWeight)
        .onAreaChange((_: Area, newValue: Area) => {
          this.tabTextWidthMap?.set(index.toString(), newValue.width)
          this.isShowText = true
        })
        .height((!_this.isHideDivider && _this.isShowText && _this.tabType == TabType.DEFAULT) ?
          _this.tabModel.tabItemHeight : undefined)
      //默认情况下，有这条指示器线
      if (!_this.isHideDivider && _this.isShowText && _this.tabType == TabType.DEFAULT) {
        Divider()
          .lineCap(_this.tabModel.tabDividerLineCapStyle)
          .strokeWidth(_this.tabModel.tabDividerStrokeWidth)
          .color(_this.tabModel.tabDividerColor)
          .width(_this.tabModel.isTabDividerTextWidth ? this.tabTextWidthMap?.get(index.toString()) :
            _this.tabModel.tabDividerWidth)
          .margin({
            top: -Number(_this.tabModel.tabDividerStrokeWidth) - Number(_this.tabModel.tabDividerMarginTop),
            bottom: _this.tabModel.tabDividerMarginBottom,
            left: _this.tabModel.tabDividerMarginLeft,
            right: _this.tabModel.tabDividerMarginRight
          })
          .opacity(_this.currentIndex === index ? 1 : 0)
      }
    }
    .width(_this.tabModel.tabItemWidth)
    .height(_this.tabModel.tabItemHeight)
    .justifyContent(FlexAlign.Center)
    .alignItems(_this.alignItems)
    .backgroundColor(_this.currentIndex === index ? _this.tabModel.tabSelectedBgColor : _this.tabModel.tabNormalBgColor)
    .margin(_this.tabModel.tabItemMargin)
  }

  build() {
    BaseTabLayout({
      tabBar: this.tabBar,
      itemPage: this.itemPage,
      barBackgroundColor: this.barBackgroundColor,
      isTabClickIntercept: this.isTabClickIntercept,
      itemTabIndicator: () => {
        this.tabItemTabIndicator(this)
      },
      tabType: this.tabType,
      itemTab: (index: number, item: string) => {
        this.tabItem(this, index, item)
      },
      onTabAttribute: (d) => {
        d.tabDividerColor = this.tabModel.tabDividerColor
        d.tabDividerHeight = this.tabModel.tabDividerStrokeWidth
        d.tabDividerMarginTop = this.tabModel.tabDividerMarginTop
        d.tabDividerWidth = this.tabModel.tabDividerWidth
        d.tabDividerRadius = this.tabModel.tabDividerRadius
        d.tabSelectedColor = this.tabModel.tabSelectedColor
        d.tabNormalColor = this.tabModel.tabNormalColor
        d.tabSelectedSize = this.tabModel.tabSelectedSize
        d.tabNormalSize = this.tabModel.tabNormalSize
      },
      currentIndex: this.currentIndex,
      tabScrollable: this.tabScrollable,
      onChangePage: (position: number) => {
        if (this.onChangePage != undefined) {
          this.onChangePage(position)
        }
        if (this.isTabClickIntercept) {
          return
        }
        this.currentIndex = position
      },
      tabWidth: this.tabWidth,
      tabHeight: this.tabHeight,
      tabModel: this.tabModel,
      isHideDivider: this.isHideDivider,
      isTabAlignLeft: this.isTabAlignLeft,
      barMode: this.barMode,
      onTabBarClick: this.onTabBarClick,
      isShowTabMenu: this.isShowTabMenu,
      tabMenu: this.tabMenu,
      tabLeftMenu: this.tabLeftMenu,
      tabMenuWidth: this.tabMenuWidth,
      tabMenuMarginRight: this.tabMenuMarginRight,
      tabIndicatorBorder: this.tabIndicatorBorder
    })
  }
}