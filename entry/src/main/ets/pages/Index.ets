import router from '@ohos.router';

@Entry
@Component
struct Index {
  private items: string[] = [
    "封装底部导航", "自定义底部导航", "自定义底部导航纯文字", "底部导航(中间图片)",
    "可滑动导航", "普通导航"
  ]
  private routers: string[] = [
    "pages/BottomTabPage1", "pages/BottomTabPage2",
    "pages/BottomTabPage3", "pages/BottomTabPage4",
    "pages/TabLayoutScrollPage", "pages/TabLayoutPage"
  ]

  build() {
    Column() {
      Grid() {
        ForEach(this.items, (item: string, index: number) => {
          GridItem() {
            Text(item)
              .fontColor(Color.Red)
              .textStyle()
              .textAlign(TextAlign.Center)
              .onClick(() => {
                //点击
                router.pushUrl({ url: this.routers[index] })
              })
          }
        }, (item: string) => JSON.stringify(item))
      }.columnsTemplate("1fr 1fr")
      .rowsGap(10)
      .columnsGap(10)
    }
    .width('100%')
    .height("100%")
    .justifyContent(FlexAlign.Center)

  }

  @Styles
  textStyle() {
    .height(50)
    .width("100%")
    .border({ color: Color.Red, width: 1 })
  }
}