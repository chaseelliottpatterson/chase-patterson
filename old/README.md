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
and 
`sudo apt update && sudo apt install git -y`
and
`git clone https://github.com/chaseelliottpatterson/chase-patterson.git website`
and 
`cd website`
and
`docker build -t website .`
and
`docker run -d -p 80:80 --name website-container website`

```cd ~/my-website
git pull origin main  # Fetch latest updates
docker build -t my-website .  # Rebuild the container
docker stop website-container  # Stop the old container
docker rm website-container  # Remove the old container
docker run -d -p 80:80 --name website-container my-website  # Run the new one
```

_________________________________________________________________________________________________________________________________________________________
`sudo apt update && sudo apt install docker -y && sudo apt install docker-compose -y && sudo usermod -aG docker $USER && sudo apt install git -y && git clone https://github.com/chaseelliottpatterson/chase-patterson.git website`