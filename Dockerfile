FROM quay.octanner.io/base/oct-ruby:2.4.1-onbuild
EXPOSE 9000
RUN chmod +x start.sh

CMD ./start.sh
