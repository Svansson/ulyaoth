buildarch="$(uname -m)"
version=1.5.0

useradd ulyaoth
cd /home/ulyaoth
yum install -y ant
su ulyaoth -c "rpmdev-setuptree"

su ulyaoth -c "git clone -b release git://github.com/LucidWorks/banana.git"
su ulyaoth -c "mkdir -p /home/ulyaoth/banana/build"
cd /home/ulyaoth/banana
su ulyaoth -c "ant"
mv /home/ulyaoth/banana/build/banana-0.war /home/ulyaoth/rpmbuild/SOURCES/banana.war

cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-banana/SOURCES/banana-context.xml"

cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-banana/SPECS/ulyaoth-banana.spec"

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth-banana.spec
fi

su ulyaoth -c "rpmbuild -bb ulyaoth-banana.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/