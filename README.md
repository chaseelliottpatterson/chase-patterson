# chase-patterson
Personal Notetaking:
Setting up docker image
`cd <Dockerfile directory location>`
`build -t <image-name> .`

Setting up container with auto reload
`docker run -d -p 8000:80 -v C:\Users\Binary\Documents\GitHub\chase-patterson:/usr/share/nginx/html --name docker-container-website docker-image-website`


set up google cloud vm for hosting currently setup as "website-vm on" Ubuntu 22.04 LTS and e2-micro. 

once container setup ran
`sudo apt update && sudo apt install docker.io -y`
and 
`sudo usermod -aG docker $USER`