# 使用官方的 Jekyll 镜像作为构建环境
FROM jekyll/jekyll:4.2.0 AS build

# 将当前目录的所有文件复制到容器的 /srv/jekyll 目录
COPY . /srv/jekyll

# 执行 Jekyll 构建命令，生成静态文件到 ./_site
RUN jekyll build

# 使用一个轻量级的 Web 服务器来服务生成的文件
FROM nginx:alpine

# 将之前构建阶段生成的 _site 目录内容复制到 Nginx 的网页目录
COPY --from=build /srv/jekyll/_site /usr/share/nginx/html
