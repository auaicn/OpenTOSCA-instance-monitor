class Stats {
  int activeAnon;
  int activeFile;
  int cache;
  int dirty;
  int hierarchicalMemoryLimit;
  int hierarchicalMemswLimit;
  int inactiveAnon;
  int inactiveFile;
  int mappedFile;
  int pgfault;
  int pgmajfault;
  int pgpgin;
  int pgpgout;
  int rss;
  int rssHuge;
  int totalActiveAnon;
  int totalActiveFile;
  int totalCache;
  int totalDirty;
  int totalInactiveAnon;
  int totalInactiveFile;
  int totalMappedFile;
  int totalPgfault;
  int totalPgmajfault;
  int totalPgpgin;
  int totalPgpgout;
  int totalRss;
  int totalRssHuge;
  int totalUnevictable;
  int totalWriteback;
  int unevictable;
  int writeback;

  Stats(
      {this.activeAnon,
      this.activeFile,
      this.cache,
      this.dirty,
      this.hierarchicalMemoryLimit,
      this.hierarchicalMemswLimit,
      this.inactiveAnon,
      this.inactiveFile,
      this.mappedFile,
      this.pgfault,
      this.pgmajfault,
      this.pgpgin,
      this.pgpgout,
      this.rss,
      this.rssHuge,
      this.totalActiveAnon,
      this.totalActiveFile,
      this.totalCache,
      this.totalDirty,
      this.totalInactiveAnon,
      this.totalInactiveFile,
      this.totalMappedFile,
      this.totalPgfault,
      this.totalPgmajfault,
      this.totalPgpgin,
      this.totalPgpgout,
      this.totalRss,
      this.totalRssHuge,
      this.totalUnevictable,
      this.totalWriteback,
      this.unevictable,
      this.writeback});

  Stats.fromJson(Map<String, dynamic> json) {
    activeAnon = json['active_anon'];
    activeFile = json['active_file'];
    cache = json['cache'];
    dirty = json['dirty'];
    hierarchicalMemoryLimit = json['hierarchical_memory_limit'];
    hierarchicalMemswLimit = json['hierarchical_memsw_limit'];
    inactiveAnon = json['inactive_anon'];
    inactiveFile = json['inactive_file'];
    mappedFile = json['mapped_file'];
    pgfault = json['pgfault'];
    pgmajfault = json['pgmajfault'];
    pgpgin = json['pgpgin'];
    pgpgout = json['pgpgout'];
    rss = json['rss'];
    rssHuge = json['rss_huge'];
    totalActiveAnon = json['total_active_anon'];
    totalActiveFile = json['total_active_file'];
    totalCache = json['total_cache'];
    totalDirty = json['total_dirty'];
    totalInactiveAnon = json['total_inactive_anon'];
    totalInactiveFile = json['total_inactive_file'];
    totalMappedFile = json['total_mapped_file'];
    totalPgfault = json['total_pgfault'];
    totalPgmajfault = json['total_pgmajfault'];
    totalPgpgin = json['total_pgpgin'];
    totalPgpgout = json['total_pgpgout'];
    totalRss = json['total_rss'];
    totalRssHuge = json['total_rss_huge'];
    totalUnevictable = json['total_unevictable'];
    totalWriteback = json['total_writeback'];
    unevictable = json['unevictable'];
    writeback = json['writeback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_anon'] = this.activeAnon;
    data['active_file'] = this.activeFile;
    data['cache'] = this.cache;
    data['dirty'] = this.dirty;
    data['hierarchical_memory_limit'] = this.hierarchicalMemoryLimit;
    data['hierarchical_memsw_limit'] = this.hierarchicalMemswLimit;
    data['inactive_anon'] = this.inactiveAnon;
    data['inactive_file'] = this.inactiveFile;
    data['mapped_file'] = this.mappedFile;
    data['pgfault'] = this.pgfault;
    data['pgmajfault'] = this.pgmajfault;
    data['pgpgin'] = this.pgpgin;
    data['pgpgout'] = this.pgpgout;
    data['rss'] = this.rss;
    data['rss_huge'] = this.rssHuge;
    data['total_active_anon'] = this.totalActiveAnon;
    data['total_active_file'] = this.totalActiveFile;
    data['total_cache'] = this.totalCache;
    data['total_dirty'] = this.totalDirty;
    data['total_inactive_anon'] = this.totalInactiveAnon;
    data['total_inactive_file'] = this.totalInactiveFile;
    data['total_mapped_file'] = this.totalMappedFile;
    data['total_pgfault'] = this.totalPgfault;
    data['total_pgmajfault'] = this.totalPgmajfault;
    data['total_pgpgin'] = this.totalPgpgin;
    data['total_pgpgout'] = this.totalPgpgout;
    data['total_rss'] = this.totalRss;
    data['total_rss_huge'] = this.totalRssHuge;
    data['total_unevictable'] = this.totalUnevictable;
    data['total_writeback'] = this.totalWriteback;
    data['unevictable'] = this.unevictable;
    data['writeback'] = this.writeback;
    return data;
  }
}
