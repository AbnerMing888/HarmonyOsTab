/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/20
 * INTRODUCE:tab指示器下划线
 * */
export class BaseTabAttribute {
  tabSelectedColor?: ResourceColor = Color.Black //标题选中颜色
  tabNormalColor?: ResourceColor = Color.Gray //标题未选中颜色
  tabSelectedSize?: Length = 16 //标题选中文字大小
  tabNormalSize?: Length = 16 //标题未选中文字大小

  tabDividerColor?: ResourceColor = Color.Black //下划线的颜色
  tabDividerHeight?: Length = 3
  tabDividerWidth?: Length
  tabDividerRadius?: Length = 0
  tabDividerMarginTop?: Length = 0 //距离文字高度
}