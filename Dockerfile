# 使用官方的Ruby镜像作为基础
FROM ruby

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    nodejs \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# 复制项目文件到工作目录
COPY . .

# 安装依赖
RUN bundle install

# 设置环境变量
ENV RAILS_ENV=production

# 运行数据库迁移和预编译资源
RUN bundle exec rake db:create db:migrate assets:precompile

# 暴露端口
EXPOSE 3000

# 启动Huginn
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
