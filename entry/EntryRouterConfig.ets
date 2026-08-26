import { RouterConfig,routerGetBuilderType, routerInitBuilder,NavDestinationView } from '@abner/router';

/**
 * AUTHOR:AbnerMing
 * INTRODUCE:动态配置路径
 * */
function importPath(builderName: string) {
  switch (builderName) {

  }
}

/**
 * AUTHOR:AbnerMing
 * INTRODUCE:动态配置组件
 * */
@Builder
export function viewBuilder(params?:Object) {
  NavDestinationView() {

  }

}


/**
 * AUTHOR:AbnerMing
 * DATE:2026年8月26日 11时37分4秒
 * INTRODUCE:路由配置,此路由配置文件为自动生成，无特殊情况下请无须改动
 * */
export class EntryRouterConfig implements RouterConfig {
  getModuleName(): string {
    return "entry"
  }

  async initRouter(builderName: string): Promise<void> {
    return await new Promise((resolve: Function) => {
      importPath(builderName)
      routerInitBuilder(builderName, wrapBuilder(viewBuilder))
      resolve()
    })
  }
}