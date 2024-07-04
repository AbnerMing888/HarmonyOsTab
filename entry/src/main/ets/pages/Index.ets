import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text("封装底部导航")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/BottomTabPage1" })
        })
      Text("自定义底部导航")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/BottomTabPage2" })
        })
      Text("自定义底部导航纯文字")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/BottomTabPage3" })
        })

      Text("封装导航【普通】")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/TabLayoutPage1" })
        })

      Text("封装导航【均分】")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/TabLayoutPage2" })
        })

      Text("封装导航【滑动】")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/TabLayoutPage3" })
        })

      Text("封装导航【居左】")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/TabLayoutPage4" })
        })
      Text("封装导航【居左滑动】")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/TabLayoutPage5" })
        })

      Text("封装导航【右边按钮】")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/TabLayoutPage6" })
        })
      Text("自定义导航")
        .fontColor(Color.Red)
        .textStyle()
        .onClick(() => {
          //点击
          router.pushUrl({ url: "pages/TabLayoutPage7" })
        })
    }
    .width('100%')
    .height("100%")
    .justifyContent(FlexAlign.Center)

  }

  @Styles
  textStyle() {
    .height(40)
    .margin({ top: 20 })
    .padding({ left: 50, right: 50 })
    .border({ color: Color.Red, width: 2, radius: 20 })

  }
}