# 使用官方的 Ruby 镜像作为基础镜像
FROM ruby

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    nodejs \
    imagemagick \
    libpq-dev \
    postgresql-client \
    curl \
    git \
 && rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV RAILS_ENV=production

# 设置工作目录
WORKDIR /huginn

# 复制当前目录中的所有文件到容器中的 /huginn 目录下
COPY . /huginn

# 安装依赖
RUN bundle install --deployment --without development test

# 创建数据库并运行迁移
RUN bundle exec rake db:create db:migrate

# 预编译 assets
RUN bundle exec rake assets:precompile

# 暴露 Huginn 使用的端口（默认是 3000）
EXPOSE 3000

# 容器启动时运行的命令
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
