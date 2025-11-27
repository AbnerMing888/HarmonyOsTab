/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/20
 * INTRODUCE:TabBar对象
 * */
export class TabBar {
  title?: string
  selectedIcon?: PixelMap | ResourceStr | DrawableDescriptor //选中的icon
  normalIcon?: PixelMap | ResourceStr | DrawableDescriptor //未选中的icon

  constructor(title?: string, selectedIcon?: PixelMap | ResourceStr | DrawableDescriptor, normalIcon?: PixelMap | ResourceStr | DrawableDescriptor) {
    this.title = title
    this.selectedIcon = selectedIcon
    this.normalIcon = normalIcon
  }
}

