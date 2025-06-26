<?php

return new PDO(
  "mysql:host=" . getenv('DB_HOST') . ";dbname=" . getenv('DB_NAME'),
  getenv('DB_USER'),
  getenv('DB_PASSWORD'),
  [PDO::ATTR_PERSISTENT => true]
);

