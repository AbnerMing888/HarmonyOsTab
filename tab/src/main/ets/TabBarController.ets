export class TabBarController {
  changeTitle(position: number, title: string) {
    if (this.onChangeTitle != undefined) {
      this.onChangeTitle(position, title)
    }
  }

  onChangeTitle?: (position: number, title: string) => void
}