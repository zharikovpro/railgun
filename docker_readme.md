## install docker image
sudo docker build -t {image_name} .
sudo docker run -i -t -v {project_local_path}:/railgun -p {outPort}:{inside port} {image_name}
### example
sudo docker run -i -t -v ~/Desktop/Ruby/railgun/:/railgun -p 5000:3000 railgun-browser

sudo docker ps
## run rails app
sudo docker exec -it {CONTAINER ID} bundle exec rails s -p {inside port} -b '0.0.0.0'
### example
docker exec -it 22115f4b376e bundle exec rails s -p 3000 -b '0.0.0.0'

## run tests
sudo docker exec -it {CONTAINER ID} rake ci/bundle exec rspec
### example
docker exec -it 22115f4b376e bundle exec rspec

https://hub.docker.com/r/mifrill/railgun-browser/
