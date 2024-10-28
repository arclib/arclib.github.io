---
title: 侧边栏
icon: 
order: 4
---
侧边栏包含相关的文档列表，文档标题以及博客模式下的博主信息。

主题允许你通过 文件结构 和 文档标题 自动生成侧边栏，也可以手动配置。



这里以使用为主

<!--more-->
## 侧边栏链接
站点侧边栏的配置由主题选项中的 sidebar 控制。

### 字符串格式
同导航栏，你可以填入一个包含多个文件链接的数组，作为侧边栏基本的配置
数组的每一项会自动提取对应文件的图标与标题，渲染为一个侧边栏项目。
你可以省略 .md 扩展名，以 / 结尾的路径会被推断为 /README.md。

```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    sidebar: ["/zh/README.md", "/zh/guide/README.md", "/zh/config/README.md"],
  }),
};
```
### 对象格式
同导航栏，如果你对页面的图标不满意或者觉得页面标题太长，你可以改为配置一个对象。可用的配置项有:    
- text: 项目文字
- link 项目链接
- icon: 项目图标 (可选) 
- activeMatch: 项目激活匹配 (可选)，支持正则字符串。 **激活高亮**
```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    sidebar: [
      {
        text: "指南",
        link: "/zh/guide/README.md",
        icon: "lightbulb",
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

### 分组与嵌套
如果你需要展示嵌套结构的侧边栏，你可以将同类链接整理成菜单分组。

你需要使用 对象格式 ，并提供额外的 children 选项设置链接列表。

和导航栏一样，你可以在侧边栏中使用 prefix 来为组内的每个链接添加默认的路径前缀，

侧边栏额外支持设置 collapsible: true 来使菜单分组可折叠，并且你可以设置 expanded: true 来使可折叠的分组默认展开。

```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    sidebar: [
      {
        // 必要的，分组的标题文字
        text: "分组 1",
        // 可选的, 分组标题对应的图标
        icon: "tip",
        // 可选的, 分组标题对应的链接
        link: "/foo/",
        // 可选的，会添加到每个 item 链接地址之前
        prefix: "/foo/",
        // 可选的, 设置分组是否可以折叠，默认值是 false,
        collapsible: true,
        // 可选的。设置分组是否默认展开，默认值是 false
        expanded: true,
        // 必要的，分组的子项目
        children: [
          "README.md" /* /foo/index.html */,
          /* ... */
          "geo.md" /* /foo/geo.html */,
        ],
      },
      {
        text: "分组 2",
        children: [
          /* ... */
          "bar.md" /* /ray/bar.html */,
          "baz.md" /* /ray/baz.html */,
        ],
      },
    ],
  }),
};
```
侧边栏分组也可以进行嵌套:
```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    sidebar: [
      {
        text: "Group",
        prefix: "/",
        children: [
          "baz" /* /baz.html */,
          {
            text: "Sub Group 1",
            children: ["quz" /* /quz.html */, "xyzzy" /* /xyzzy.html */],
          },
          {
            text: "Sub Group 2",
            prefix: "corge/",
            children: [
              "fred" /* /corge/fred.html */,
              "grault" /* /corge/grault.html */,
            ],
          },
          "foo" /* /foo.html */,
        ],
      },
    ],
  }),
};
```
通常情况下，你可能希望搭配 prefix 使用来快速还原文档的结构。

比如，将你的页面文件为下述的目录结构:
```tree
.
├─ README.md
├─ contact.md
├─ about.md
├─ foo/
│   ├─ README.md
│   ├─ one.md
│   └─ two.md
└─ bar/
    ├─ README.md
    ├─ three.md
    └─ four.md
```
你就可以进行以下配置:
```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
  theme: hopeTheme({
    sidebar: [
      "/" /* / */,
      {
        text: "Foo",
        prefix: "/foo/",
        children: [
          "" /* /foo/ */,
          "one" /* /foo/one.html */,
          "two" /* /foo/two.html */,
        ],
      },
      {
        text: "Bar",
        prefix: "/bar/",
        children: [
          "" /* /bar/ */,
          "three" /* /bar/three.html */,
          "four" /* /bar/four.html */,
        ],
      },
      "/contact" /* /contact.html */,
      "/about" /* /about.html */,
    ],
  }),
};
```
### 多个侧边栏
如果你想为不同的页面组来显示不同的侧边栏，你需要通过 路径前缀: 侧边栏配置 的格式为侧边栏配置一个对象。

目录结构:
```tree
.
├─ README.md
├─ contact.md
├─ about.md
├─ foo/
│   ├─ README.md
│   ├─ one.md
│   └─ two.md
└─ bar/
    ├─ README.md
    ├─ three.md
    └─ four.md
```
你就可以遵循以下的侧边栏配置，来为不同路径显示不同的分组:
```js
import { hopeTheme } from "vuepress-theme-hope";

export default {
    theme: hopeTheme({
        sidebar: {
            "/foo/": [
                "" /* /foo/ */,
                "one" /* /foo/one.html */,
                "two" /* /foo/two.html */,
            ],

            "/bar/": [
                "" /* /bar/ */,
                "three" /* /bar/three.html */,
                "four" /* /bar/four.html */,
            ],

            // fallback
            "/": [
                "" /* / */,
                "contact" /* /contact.html */,
                "about" /* /about.html */,
            ],
        },
    }),
};
```