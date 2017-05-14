# scpage
Generate markdown and html pages for source packages

To build and install

        \rm scpage-1.0 scpage_* -rf \
                && cd scpage \
                && tar -czvf ../scpage_1.0.orig.tar.gz . \
                && debuild -us -uc \
                && sudo dpkg -i scpage*.deb \
                && scpage scpage_1.0-1.dsc
