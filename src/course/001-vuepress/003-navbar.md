---
title: 导航栏
icon: 
order: 3
---
**导航栏包含:**

- 站点名称    
- 搜索框
- 导航栏链接
- 多语言选择菜单
- 仓库链接
- 外观弹窗。

它们都是可配置的，你也可以完全自定义导航栏布局。

**参考**

>https://theme-hope.vuejs.press/zh/guide/layout/navbar.html

这里以使用为主

<!--more-->

## 导航栏链接
你可以在主题选项中通过 navbar 配置导航栏链接，它接受一个数组。

### 字符串格式
配置导航栏最简单的方式，是依次填入需要展示的页面文件的路径，这样导航栏的文字、图标和链接会自动通过对应文件的Frontmatter配置生成。

`.md`结尾的可以省略，例如`/guide/README.md`等同`/guide/README`  
以 `/` 结尾的路径会被推断为 `/README.md`

```js
import { defineUserConfig } from "vuepress";
import { hopeTheme } from "vuepress-theme-hope";

export default defineUserConfig({
  theme: hopeTheme({
    navbar: ["/guide/README.md", "/config/README.md", "/faq.md"],
  }),
});
```
### 对象格式
- text:: 项目文字
- link: 项目链接
- icon: 项目图标 (可选) **不配置默认没有图标**
- activeMatch: 项目激活匹配 (可选)，支持正则字符串。 **匹配的会高亮显示**

```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    navbar: [
        
      {
        text: "指南",
        link: "/zh/guide/README.md",
        icon: "lightbulb",
        // 仅在 `/zh/guide/` 激活
        activeMatch: "^/zh/guide/$",
      },
        
      { text: "配置", link: "/zh/config/README.md", icon: "config" },
        
      { 
        text: "常见问题", 
        link: "/zh/faq.md", 
        icon: "circle-question",
        // 会在 `/zh/faq` 开头的路径激活
        // 所以当你前往 `/zh/faq/xxx.html` 时也会激活
        activeMatch: "^/zh/faq",
      },
        
    ],
  }),
};
```
### 下拉列表

如果你需要展示较多的链接，你可以将同类链接整理成下拉列表。
你需要设置对象式导航栏配置项，并提供额外的 children 选项设置链接列表:

```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    navbar: [
        
      {
        text: "基础",
        icon: "circle-info",
        children: ["/zh/basic/markdown.md", "/zh/basic/vuepress.md"],
      },
        
    ],
  }),
};
```
大多数情况下，导航栏的分组项目都属于同一类别，会放在同一个子目录下，它们具有相同的路径前缀。

为了简化配置，你可以添加 prefix 字段为分组的每一个子链接添加一个前缀:

```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    navbar: [
        
      {
        text: "基础",
        icon: "circle-info",
        prefix: "/zh/basic/",
        children: ["markdown.md", "vuepress.md"],
      },
        
    ],
  }),
};
```
此外，你还可以通过嵌套的 children 来在下拉列表中设置分组:
```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    navbar: [
        
      {
        text: "插件列表",
        icon: "puzzle-piece",
        children: [
            
          {
            text: "内置插件",
            children: [
              /* 一些子项目 */
            ],
          },
            
          {
            text: "外部插件",
            children: [
              /* 一些子项目 */
            ],
          },
            
        ],
      },
        
    ],
  }),
};
```






