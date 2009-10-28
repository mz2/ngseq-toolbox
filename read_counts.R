# Count the total number of mapped reads from .counts files and
# report them relative to the smallest and largest

library(args)
dir=argv$dir

countfs = list.files(dir,".count")

totalreads = data.frame(name=sub("^(\\d+_\\d+).*","\\1",countfs,perl=T),reads=0,weights_from_smallest=0,weights_from_largest=0)
for (i in 1:length(countfs)) {
  cfile = countfs[i]
  abspath = paste(dir,cfile,sep="/")
  cdata = read.table(abspath)
  totalreads[i,2] = sum(cdata[,2])
}

smallest = min(totalreads$reads)
largest = max(totalreads$reads)

totalreads$weights_from_smallest = smallest / totalreads$reads 
totalreads$weights_from_largest = largest / totalreads$reads

write.table(totalreads,row.names=F,quote=F,sep="\t")
