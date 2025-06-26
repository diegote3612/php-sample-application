FROM mysql:8.0


RUN echo '[mysqld]\ndefault_authentication_plugin=caching_sha2_password\ncharacter-set-server=utf8mb4\ncollation-server=utf8mb4_unicode_ci\ninnodb_buffer_pool_size=256M\nmax_allowed_packet=64M\n' > /etc/mysql/conf.d/custom.cnf


COPY sql/db.sql /docker-entrypoint-initdb.d/


RUN chown -R mysql:mysql /docker-entrypoint-initdb.d/
