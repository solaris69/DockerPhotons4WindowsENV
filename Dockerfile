FROM nginx:1.23.3

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]