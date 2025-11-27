export class TabDividerAttr {
  height?: number | string = 2
  width?: Length
  color?: ResourceColor = "#222222"
  isBottom?: boolean = true //是否在底部,默认在底部
  marginTop?: Length = 0
  marginBottom?: Length = 0
  lineCap?: LineCapStyle = LineCapStyle.Square
}