#!/bin/bash

# List of ports to be used for EXPOSE, in order
PORTS=(9090 8080 8888 8081 8761 8083 8082)

# Counter for port assignment
index=0

# Loop through all directories starting with "spring-petclinic"
for dir in spring-petclinic*/ ; do
  # Check if it's a directory
  if [ -d "$dir" ]; then
    dockerfile="$dir/Dockerfile"

    # Create Dockerfile with the desired content
    echo "Creating Dockerfile in $dir with port ${PORTS[$index]}"

    cat > "$dockerfile" << EOF
FROM amazoncorretto:17
ARG JAR_FILE=/target/*.jar
COPY \${JAR_FILE} app.jar
ENV SPRING_PROFILES_ACTIVE docker,mysql
EXPOSE ${PORTS[$index]}
ENTRYPOINT ["java", "-jar", "/app.jar"]
EOF

    echo "Dockerfile created with EXPOSE ${PORTS[$index]} in $dir"

    # Increment index to assign the next port
    index=$((index + 1))

    # Stop if we run out of ports
    if [ $index -ge ${#PORTS[@]} ]; then
      echo "All ports have been assigned."
      break
    fi
  fi
done

echo "Dockerfile creation with ports completed!"

