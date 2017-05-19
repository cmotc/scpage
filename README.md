# scpage
Generate markdown and html pages for source packages

To build and install

                git clone https://github.com/cmotc/scpage \
                && cd scpage \
                && tar -czvf ../scpage_1.0.orig.tar.gz . \
                && debuild -us -uc \
                && sudo dpkg -i scpage*.deb \
                && scpage scpage_1.0-1.dsc
