import { finishPage, getARouter, routerInitConfig } from '@abner/router';
import { AbilityStage } from '@kit.AbilityKit';
import { EntryRouterConfig } from '../../../EntryRouterConfig';
import { BarMenuType, initTitleBar } from '@abner/bar';
import { ViewRouterConfig } from 'view';

export class App extends AbilityStage {
  onCreate(): void {
    routerInitConfig([
      new ViewRouterConfig(getARouter()),
      new EntryRouterConfig()
    ])

    this.initBar()
  }

  private initBar() {
    initTitleBar({
      onBarAttribute: (attr) => {
        attr.isAvoidanceNavigation = true //避开导航栏
        attr.leftMenuType = BarMenuType.IMAGE
        attr.leftIcon = $r("app.media.common_back")
        attr.onLeftClick = () => {
          finishPage()
        }
      }
    })
  }
}