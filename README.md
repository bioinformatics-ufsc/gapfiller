# gapfiller
Docker for gapfiller version 1.1.1 (installed in a debian:squeeze version, 2011)

# building an image
docker build -t gapfiller:1.1.1 .

# running 

docker \
  run \
  --rm \
  --interactive \
  --user $(id -u):$(id -g) \
  --volume ${PWD}:/data \
  --workdir /data \
  gapfiller:1.1.1 \
GapFiller.pl -l <Your_sample>_library_SSPACE.txt -s <Your_sample>_scaffolds.fasta -n 20 -d 50 -t 10 -T 10 -i 10 -b <Your_sample_name> 1>GapFiller.out 2>GapFiller.err

