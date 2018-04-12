# Préparation de l'hôte

## Formatage
```
file /dev/disk/by-id/*
mkfs.btrfs -f /dev/disk/by-id/scsi-0DO_Volume_volume-devoxx2018
```

## Montage temporaire
```
mkdir /mnt/volume-devoxx2018
mount -o defaults,discard /dev/disk/by-id/scsi-0DO_Volume_volume-devoxx2018 /mnt/volume-devoxx2018/
```

## Test avec un fichier
```
df -h -x tmpfs -x devtmpfs
echo "success"  | sudo tee /mnt/volume-devoxx2018/test
cat /mnt/volume-devoxx2018/test
```

## Montage permanent
```
umount /mnt/volume-devoxx2018
vi /etc/fstab
echo "/dev/disk/by-id/scsi-0DO_Volume_volume-devoxx2018 /mnt/volume-devoxx2018 btrfs defaults,nofail,discard 0 2" >> /etc/fstab
mount -a
df -h -x tmpfs -x devtmpfs
```

## Clonage des projets
```
git clone https://github.com/Treeptik/devoxx2018.git
git clone https://github.com/Treeptik/devoxx2018-demo.git
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

## Construire les images Jenkins avec support BtrFS
```
cd ~/devoxx2018
groupadd -g 1000 jenkins
useradd -g jenkins jenkins
docker build --build-arg GID=1000 -t treeptik/jenkins jenkins
```

## Lancement des applications
```
./startup.sh
```

## Configuration GitLab & Jenkins

Il faut créer un nouveau projet dans GitLab issue du projet GitHub public.
Egalement créer un job multibuild pipeline basé sur le projet github

# Préparer les données 

## Création des données de référence

```
mkdir /btrfs/pg-data
```

## Lancer le container pour provisionner les données

```
docker run --name postgres-srv \
			-e POSTGRES_PASSWORD=mysecretpassword \
			-v /btrfs/pg-data:/var/lib/postgresql/data \
			-v `pwd`/scripts/users.sql:/opt/scripts/users.sql \
			-d postgres

docker exec -it postgres-srv bash

container> psql -U postgres
 postgres> \timing
 postgres> \i /opt/scripts/users.sql
```

## Création du volume BtrFS

```
btrfs subvolume create /btrfs/pg-data-ref
chown -R jenkins:jenkins /btrfs/pg-data-ref/
```

