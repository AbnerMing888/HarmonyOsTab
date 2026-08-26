import { appTasks } from '@ohos/hvigor-ohos-plugin';
import { abnerRouterFilter } from 'ohos-router/router-plugin';
export default {
    system: appTasks,  /* Built-in plugin of Hvigor. It cannot be modified. */
    plugins:[
        abnerRouterFilter(true, ["tab"])
    ]         /* Custom plugin to extend the functionality of Hvigor. */
}
