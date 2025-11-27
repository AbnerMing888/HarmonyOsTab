/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/20
 * INTRODUCE:tab数据模型
 * */
export class TabModel {
  clearTabItemWidth?: boolean = false //清除条目宽度
  tabItemWidth?: Length | undefined = 100
  tabItemHeight?: Length | undefined = 56
  tabItemMargin?: Margin | Length | LocalizedMargin
  tabSelectedColor?: ResourceColor = Color.Black //标题选中颜色
  tabNormalColor?: ResourceColor = Color.Gray //标题未选中颜色
  tabSelectedBgColor?: ResourceColor = Color.Transparent //选中背景颜色
  tabNormalBgColor?: ResourceColor = Color.Transparent //未选中背景颜色
  tabSelectedWeight?: number | FontWeight | string = 500 //标题选中权重
  tabNormalWeight?: number | FontWeight | string = 400 //标题未选中权重

  tabSelectedSize?: Length = 16 //标题选中文字大小
  tabNormalSize?: Length = 16 //标题未选中文字大小
  tabLineHeight?: number | string | Resource = 20 //行高
  tabMargin?: Margin | Length | LocalizedMargin = { left: 10, right: 10 }
  tabDividerColor?: ResourceColor = Color.Black //下划线的颜色
  tabDividerStrokeWidth?: number | string = 3
  tabDividerLineCapStyle? = LineCapStyle.Square //默认圆角矩形
  tabDividerWidth?: Length = 100
  tabDividerMarginTop?: Length = 0 //距离文字高度
  tabDividerMarginBottom?: Length = 0 //距离底部
  tabDividerMarginLeft?: Length = 0 //距离左边
  tabDividerMarginRight?: Length = 0 //距离右边
  isTabDividerTextWidth?: boolean = false
  tabDividerRadius?: Length = 0
}