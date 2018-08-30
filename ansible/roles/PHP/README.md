Role Name
=========

Install and configure PHP for WordPress server

Requirements
------------

None.

Role Variables
--------------

php-fpm_conf_file = path to www.conf inside php-fpm_conf_dir

php-fpm_conf_dir = path to php-fpm.d/ directory. Usually resides in /etc

php-ini_path = path to php.ini file. Usually /etc/
php_ini_cgi_string = ";cgi.fix_pathinfo=" inside /etc/php.ini
php_ini_cgi_value = value to be assigned to php_ini_config_string
php_ini_cgi = concatenated string and value (php_ini_cgi_string+php_ini_cgi_value)

opache_conf_file = path to opcache.ini file
opcache_conf_dir = path to opcache.ini directory. Usually /etc/php.d/

opcache_revalidate_freq_string = "opcache.revalidate_freq=" inside opache.ini
opcache_validate_timestamps_string = "opcache.validate_timestamps=" inside opache.ini
opcache_accelerated_files_string = "opcache.accelerated_files=" inside opache.ini
opcache_memory_consumption_string = "opcache.memory_consumption=" inside opache.ini
opcache_interned_strings_buffer_string = "opcache.interned_strings_buffer=" inside opache.ini
opcache_fast_shutdown_string = "opcache.fast_shutdown=" inside opache.ini

opcache_revalidate_freq_value = value assigned to opcache_revalidate_freq_string
opcache_validate_timestamps_value = value assigned to opcache_validate_timestamps_string
opcache_accelerated_files_value = value assigned to opcache_accelerated_files_string
opcache_memory_consumption_value = value assigned to opcache_memory_consumption_string
opcache_interned_strings_buffer_value = value assigned to opcache_interned_strings_buffer_string
opcache_fast_shutdown_value = value assigned to opcache_fast_shutdown_string

opcache_revalidate_freq = concatenated string and value (opcache_revalidate_freq_string+opcache_revalidate_freq_value)
opcache_validate_timestamps = concatenated string and value (opcache_validate_timestamps_string+opcache_validate_timestamps_value)
opcache_accelerated_files = concatenated string and value (opcache_accelerated_files_string+opcache_accelerated_files_value)
opcache_memory_consumption = concatenated string and value (opcache_memory_consumption_string+opcache_memory_consumption_value)
opcache_interned_strings_buffer = concatenated string and value (opcache_interned_strings_buffer_string+pcache_interned_strings_buffer_value)
opcache_fast_shutdown = concatenated string and value (opcache_fast_shutdown_string+opcache_fast_shutdown_value)

Example Playbook
----------------

    - hosts: wordpress_servers
      roles:
         - PHP

License
-------

BSD

#
### Training and Resources
https://docs.ansible.com/ansible/2.5/user_guide
