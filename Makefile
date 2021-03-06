#
# Make file for building website
#
all: index.html about.html cv.html resume.html library-terminology.html presentations.html blog blog/index.html rssfeed.html

index.html: nav.md footer.md author.md blog/index.md presentations.md cli-tools.md index.tmpl
	mkpage "blogPosts=blog/index.md" "presentations=presentations.md" "cliTools=cli-tools.md" "aboutAuthor=author.md" "nav=nav.md" "footer=footer.md" index.tmpl > index.html
	git add index.html

presentations.html: presentations.md footer.md nav.md presentations.tmpl
	mkpage "mdfile=text:presentations.md" "presentations=presentations.md" "nav=nav.md" "footer=footer.md" presentations.tmpl > presentations.html
	git add presentations.html

about.html: nav.md footer.md author.md bio.md about.tmpl
	mkpage "mdfile=text:bio.md" "aboutAuthor=author.md" "pageContent=bio.md" "nav=nav.md" "footer=footer.md" about.tmpl > about.html
	git add about.html

cv.html: nav.md footer.md cv.md cv.tmpl
	mkpage "mdfile=text:cv.md" "pageContent=cv.md" "nav=nav.md" "footer=footer.md" cv.tmpl > cv.html
	git add cv.html

resume.html: nav.md footer.md resume.md resume.tmpl
	mkpage "mdfile=text:resume.md" "pageContent=resume.md" "nav=nav.md" "footer=footer.md" resume.tmpl > resume.html
	git add resume.html


library-terminology.html: nav.md footer.md library-terminology.md library-terminology.tmpl
	mkpage "mdfile=text:library-terminology.md" "pageContent=library-terminology.md" "nav=nav.md" "footer=footer.md" library-terminology.tmpl > library-terminology.html
	git add library-terminology.html

blog: blog/index.html
	git add blog/index.html

blog/index.html:
	bash blog.bash

rssfeed.html: rssfeed.md
	mkpage "mdfile=text:rssfeed.md" "pageContent=rssfeed.md" "nav=nav.md" "footer=footer.md" about.tmpl > rssfeed.html
	git add rssfeed.html

status:
	git status

save:
	git commit -am "Quick Save"
	git push origin master

website: all
	bash blog.bash
	mkrss -channel-title="R. S. Doiel" \
	   	  -channel-description="Robert's ramblings and wonderigs" \
		  -channel-link="http://rsdoiel.github.io/blog" blog rss.xml 
	sitemapper . sitemap.xml https://rsdoiel.github.io

publish: all
	bash blog.bash
	mkrss -channel-title="R. S. Doiel" \
	   	  -channel-description="Robert's ramblings and wonderigs" \
		  -channel-link="http://rsdoiel.github.io/blog" blog rss.xml 
	sitemapper . sitemap.xml https://rsdoiel.github.io
	git commit -am "save and publish"
	git push origin master

clean:
	rm $(shell findfile -s .html)

