## springer_downloader_books
Bash shell script to download all free books in pdf and epub format

Based on https://resource-cms.springernature.com/springer-cms/rest/v1/content/17858272/data/v4 I created a TSV file books.tsv (with fields 
Book Title,	Author,	English Package Name, OpenURL) so the script can process easier the data. The script will download the books in a 'download' folder organized by "English Package Name"

The script can be run several times if a book has already been downloaded it will be skipped

### Usage
```bash
sh download.sh
```

