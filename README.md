Image-1
- pulled base alpine linux (latest)
- os update
- installed java
- Created a new user appuser, set up a secure /app directory with restricted access to all other system directories.

Commands used
- docker build -t my-image .
- docker run -it my-image

Image-2
- pulled first image
- installed nginx
- exposed it on a custom port
- made it accessible via a custom domain using Ngrok

Commands used
-docker build -t my-new-image -f dockerfile_1 .
-docker run -d --name my-app --network mynet -p 8888:8081 my-new-image
