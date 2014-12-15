rm *.gem
sudo gem uninstall dimensiondata-api
gem build dimensiondata.gemspec
sudo gem install dimensiondata-0.1.3.gem
