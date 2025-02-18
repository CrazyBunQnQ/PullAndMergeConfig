## parseAndCombineMyClashRules

### 特别鸣谢
[![jetbrains](jetbrains-variant-2.svg)](https://www.jetbrains.com/?from=PullAndMergeConfig)

### 简介

这是一个可以自动合并多个订阅的信息，到我们指定的基础 `clash` 配置文件库中的脚本。

可能上面这段话说的不容易理解，我们来举个例子，我们购买了不少服务，每个服务商都提供了一个代理订阅地址，我们不想切换配置文件，想把所有我们购买的服务都合并到一个配置文件，并且采用网络上面维护比较好的规则。

---
* [支持解析的代理规则](#支持解析的代理规则)
* [遇到无法解析](#遇到无法解析)
* [支持的基础规则](#支持的基础规则)
* [配置文件说明](#配置文件说明)
* [使用方法](#使用方法)
* [特别说明](#特别说明)
* [鸣谢](#鸣谢)

---

### 支持解析的规则

目前可以解析 clash 的 yaml 文件，base64 的配置文件（目前只支持解析了 v2ray 和 Trojan ，ss 由于我这边没有测试数据暂不支持）

---

### 遇到无法解析

提 issue

---

### 支持的基础规则
- [x] [Hackl0us](https://github.com/Hackl0us/SS-Rule-Snippet)

[//]: # (- [ ] [ConnersHua]&#40;https://github.com/ConnersHua/Profiles&#41; 由于这个规则修改后用了太多的 core feature ，我在 mac 上没法测试，所以暂时没法测试是否有效。)

---

### 配置文件说明

文件太长，参考 [配置文件说明](config/.config.yaml)。另外需要多说一句，使用之前先看到自己的基础规则都支持啥，配置文件就是为了可以更多的自定义而已，不要一股脑的弄上去，弄坏了也不知道咋回事，多测试测试

---

### 使用方法

1. 参考 `config/template.yaml` 修改为 `config/你的配置.yaml`。 最关键的节点是 `pull-proxy-source` 这里面配置的就是你的服务 `订阅链接`。其他的配置其实可以不用改，如果要更改就做好详尽的测试，里面的每个节点在目前支持的基础规则我都保证测试可用，如果你用不了，那就自己好好查查。另外一个节点是 `Proxy` 这里面可以配置你自己搭建的，或者没有配置文件的节点。配置文件里面的内容最终都会合并到配置文件里面去。
   > 注意配置文件要放在运行目录的 `config` 目录下
2. 运行
   - 如果是 `clone` 下来的项目就在配置好 `go` 的环境以后，执行 `go run main.go Port` 就可以了。（注意，如果报错了第一反应就是检查网络，别是网络不通。）`Port` 是你服务器要开启的端口。
   - 如果是下载的可执行文件，就在命令行下运行可执行文件 + `Port` 就ok了。
3. 然后访问你的 `http://ip:port/parse?name=你的配置&baseName=BaseRuleName`。 `你的配置` 这个就是上面操作你自己更改的配置文件名称，`BaseRuleName` 这个名字就是在配置文件中 `base-config` 节点下的 `name`。
4. 如果没问题，就可以看到输出配置文件，如果有问题去 `log/errors.txt` 查看日志文件。

例如: 

配置文件使用 `config/template.yaml`

目录结构如下:
![目录结构](dir.png)

```shell
cd out
clash_merge.exe 6789
# 服务启动，端口：6789
```

访问 `http://localhost:6789/parse?name=my&baseName=CrazyBunQnQ` 即可获取合并后的 Clash 配置文件
该地址直接在 Clash 中使用即可，包括订阅的节点以及自定义规则等，详见 [配置文件说明](config/template.yaml)

---

### 特别说明

本版本开始，已经不建议在本地运行，推荐部署在服务器上。因为开启了 http 服务器，可以更长时间的在服务器上运行了，以往的 `crontab` 也不需要了，现在在用实时合并直接输出了，合并会更及时。

这一切都是在满足我的需求为第一前提下弄的，如果能够对你也有用，我深感荣幸。如果你想使用但是遇到了问题，请去提 `issue` 我会在我所知的情况下尽可能的回答。

配置文件中的 `base-config` 节点不要修改，因为你改了代码也不支持，写到配置文件中，仅仅是为了防止他们的地址变动我不用再次编译了而已。 

---

### 鸣谢

- [原作者 crazyhl](https://github.com/crazyhl/PullAndMergeConfig)
- [Hackl0us](https://github.com/Hackl0us)
- [ConnersHua](https://github.com/ConnersHua)
