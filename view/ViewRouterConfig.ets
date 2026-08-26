import { V1TabVerticalLayoutPage } from './src/main/ets/pages/V1TabVerticalLayoutPage';
import { V1TabSystemLayoutPage } from './src/main/ets/pages/V1TabSystemLayoutPage';
import { V1TabListPage } from './src/main/ets/pages/V1TabListPage';
import { V1TabLayoutScrollPage } from './src/main/ets/pages/V1TabLayoutScrollPage';
import { V1TabLayoutPage } from './src/main/ets/pages/V1TabLayoutPage';
import { V1SlidePage } from './src/main/ets/pages/V1SlidePage';
import { V1BottomTabPage9 } from './src/main/ets/pages/V1BottomTabPage9';
import { V1BottomTabPage8 } from './src/main/ets/pages/V1BottomTabPage8';
import { V1BottomTabPage7 } from './src/main/ets/pages/V1BottomTabPage7';
import { V1BottomTabPage6 } from './src/main/ets/pages/V1BottomTabPage6';
import { V1BottomTabPage5 } from './src/main/ets/pages/V1BottomTabPage5';
import { V1BottomTabPage4 } from './src/main/ets/pages/V1BottomTabPage4';
import { V1BottomTabPage3 } from './src/main/ets/pages/V1BottomTabPage3';
import { V1BottomTabPage2 } from './src/main/ets/pages/V1BottomTabPage2';
import { V1BottomTabPage13 } from './src/main/ets/pages/V1BottomTabPage13';
import { V1BottomTabPage12 } from './src/main/ets/pages/V1BottomTabPage12';
import { V1BottomTabPage11 } from './src/main/ets/pages/V1BottomTabPage11';
import { V1BottomTabPage10 } from './src/main/ets/pages/V1BottomTabPage10';
import { V1BottomTabPage1 } from './src/main/ets/pages/V1BottomTabPage1';
import {  ARouter, setARouter, RouterConfig,routerGetBuilderType, routerInitBuilder,NavDestinationView } from '@abner/router';

/**
 * AUTHOR:AbnerMing
 * INTRODUCE:动态配置路径
 * */
function importPath(builderName: string) {
  switch (builderName) {
    case "view_tabTabVerticalLayoutPage":
      import("./src/main/ets/pages/V1TabVerticalLayoutPage")
      break
    case "view_tabTabSystemLayoutPage":
      import("./src/main/ets/pages/V1TabSystemLayoutPage")
      break
    case "view_V1TabListPage":
      import("./src/main/ets/pages/V1TabListPage")
      break
    case "view_tabTabLayoutScrollPage":
      import("./src/main/ets/pages/V1TabLayoutScrollPage")
      break
    case "view_tabTabLayoutPage":
      import("./src/main/ets/pages/V1TabLayoutPage")
      break
    case "view_tabSlidePage":
      import("./src/main/ets/pages/V1SlidePage")
      break
    case "view_tabBottomTabPage9":
      import("./src/main/ets/pages/V1BottomTabPage9")
      break
    case "view_tabBottomTabPage8":
      import("./src/main/ets/pages/V1BottomTabPage8")
      break
    case "view_tabBottomTabPage7":
      import("./src/main/ets/pages/V1BottomTabPage7")
      break
    case "view_tabBottomTabPage6":
      import("./src/main/ets/pages/V1BottomTabPage6")
      break
    case "view_tabBottomTabPage5":
      import("./src/main/ets/pages/V1BottomTabPage5")
      break
    case "view_tabBottomTabPage4":
      import("./src/main/ets/pages/V1BottomTabPage4")
      break
    case "view_tabBottomTabPage3":
      import("./src/main/ets/pages/V1BottomTabPage3")
      break
    case "view_tabBottomTabPage2":
      import("./src/main/ets/pages/V1BottomTabPage2")
      break
    case "view_tabBottomTabPage13":
      import("./src/main/ets/pages/V1BottomTabPage13")
      break
    case "view_tabBottomTabPage12":
      import("./src/main/ets/pages/V1BottomTabPage12")
      break
    case "view_tabBottomTabPage11":
      import("./src/main/ets/pages/V1BottomTabPage11")
      break
    case "view_tabBottomTabPage10":
      import("./src/main/ets/pages/V1BottomTabPage10")
      break
    case "view_tabBottomTabPage1":
      import("./src/main/ets/pages/V1BottomTabPage1")
      break

  }
}

/**
 * AUTHOR:AbnerMing
 * INTRODUCE:动态配置组件
 * */
@Builder
export function viewBuilder(params?:Object) {
  NavDestinationView() {
    if (routerGetBuilderType() == "view_tabTabVerticalLayoutPage") {
      V1TabVerticalLayoutPage()
    } else 
    if (routerGetBuilderType() == "view_tabTabSystemLayoutPage") {
      V1TabSystemLayoutPage()
    } else 
    if (routerGetBuilderType() == "view_V1TabListPage") {
      V1TabListPage()
    } else 
    if (routerGetBuilderType() == "view_tabTabLayoutScrollPage") {
      V1TabLayoutScrollPage()
    } else 
    if (routerGetBuilderType() == "view_tabTabLayoutPage") {
      V1TabLayoutPage()
    } else 
    if (routerGetBuilderType() == "view_tabSlidePage") {
      V1SlidePage()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage9") {
      V1BottomTabPage9()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage8") {
      V1BottomTabPage8()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage7") {
      V1BottomTabPage7()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage6") {
      V1BottomTabPage6()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage5") {
      V1BottomTabPage5()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage4") {
      V1BottomTabPage4()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage3") {
      V1BottomTabPage3()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage2") {
      V1BottomTabPage2()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage13") {
      V1BottomTabPage13()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage12") {
      V1BottomTabPage12()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage11") {
      V1BottomTabPage11()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage10") {
      V1BottomTabPage10()
    } else 
    if (routerGetBuilderType() == "view_tabBottomTabPage1") {
      V1BottomTabPage1()
    }

  }

}


/**
 * AUTHOR:AbnerMing
 * DATE:2026年8月26日 11时37分4秒
 * INTRODUCE:路由配置,此路由配置文件为自动生成，无特殊情况下请无须改动
 * */
export class ViewRouterConfig implements RouterConfig {
  constructor(router: ARouter) {
    setARouter(router)
  }
  getModuleName(): string {
    return "view"
  }

  async initRouter(builderName: string): Promise<void> {
    return await new Promise((resolve: Function) => {
      importPath(builderName)
      routerInitBuilder(builderName, wrapBuilder(viewBuilder))
      resolve()
    })
  }
}