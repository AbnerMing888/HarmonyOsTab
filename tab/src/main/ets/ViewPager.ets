export class ViewPagerDataSource implements IDataSource {
  private list: number[] = []

  constructor(list: number[]) {
    this.list = list
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): number {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
  }

  unregisterDataChangeListener() {
  }
}

@Component
export struct ViewPager {
  cachedCount?: number = 1 //默认缓存
  disableSwipe?: boolean = false //是否禁用滑动功能
  private swiperController: SwiperController = new SwiperController()
  pageSize?: number = 0
  private _privateViewPagerDataSource: ViewPagerDataSource = new ViewPagerDataSource([])
  @BuilderParam itemLayout?: (position: number) => void //tabBar布局 自定义
  onChange?: (position: number) => void //页面滑动监听
  vWidth?: Length = "100%"
  vHeight?: Length = "100%"
  isLoop?: boolean = false //是否循环
  @Prop currentIndex?: number = 0 //默认第0个

  aboutToAppear(): void {
    let list: number[] = []
    for (let i = 1; i <= this.pageSize!; i++) {
      list.push(i);
    }
    this._privateViewPagerDataSource = new ViewPagerDataSource(list)

  }

  build() {
    Swiper(this.swiperController) {
      LazyForEach(this._privateViewPagerDataSource, (item: number) => {
        if (this.itemLayout != undefined) {
          this.itemLayout(item)
        }
      }, (item: string) => item)
    }
    .width(this.vWidth)
    .height(this.vHeight)
    .cachedCount(this.cachedCount)
    .disableSwipe(this.disableSwipe)
    .indicator(false) //不要指示器
    .loop(this.isLoop) //是否循环
    .onChange((position) => {
      //当前滑动的页面
      this.currentIndex = position
      if (this.onChange != undefined) {
        this.onChange(position)
      }
    })
    .index(this.currentIndex)

  }
}