# Cache Cache

Cache Cache (hereafter abbreviated as CCHCache) is simple in-memory and
disk cache. CCHCache provides simple, fast and convenient way to
cache any object conforming NSCopying protocol.

In general iOS apps have problems with caching their data. Or rather
invalidating and purging their cache, since it seems their disk size
requirements just keep growing bigger. Re-installing the app helps awhile,
but having well-implemented caching is the right solution.

CCHCache is a LRU cache that's designed to fix the issue of ever-growing cache
size. It lets you decide how much space is reserved for the cache and
automatically purges the least recently used items when the space fills up.
It's also dead simple to use several caches at the same time, for instance, if
you need to cache the images separate from the models.

## Basic usage

The simplest case:
```objective-c
CCHCache *cache = [CCHCache cache];
cache[@"key"] = value;
```

It's also possibe to define size for both in-memory and disk
caches and give specific name for the cache. The name is also
used as storage directory.
```objective-c
CCHCache *cache = [CCHCache cacheWithInMemorySize:<#size#>
				      andDiskSize:<#size#>
				             name:<#name#>];
cache[@"key"] = value;
```


