#!/bin/sh

echo " :: TRYING IF DOCKER WORKS HERE"
docker run hello-world

set -xe

echo ">>> ($0) RUNNINIG CONTINUOUS INTEGRATION"

# Log file friendly Gradle output
export TERM=dumb

echo  ">>> Check all license headers are in place"
./gradlew license

echo ">>> Running unit tests.."
./gradlew --stacktrace test ror


echo ">>> es61x => Running testcontainers.."
./gradlew integration-tests:test '-PesModule=es61x' || ( find . |grep hs_err |xargs cat && exit 1 )

echo ">>> es60x => Running testcontainers.."
./gradlew integration-tests:test '-PesModule=es60x' || ( find . |grep hs_err |xargs cat && exit 1 )

echo ">>> es53x => Running testcontainers.."
./gradlew  integration-tests:test '-PesModule=es53x' || ( find . |grep hs_err |xargs cat && exit 1 )

echo ">>> es52x => Running testcontainers.."
./gradlew  integration-tests:test '-PesModule=es52x' || ( find . |grep hs_err |xargs cat && exit 1 )

echo ">>> es51x => Running testcontainers.."
./gradlew  integration-tests:test '-PesModule=es51x' || ( find . |grep hs_err |xargs cat && exit 1 )


if [[ $TRAVIS_PULL_REQUEST == "true" ]] && [[ $TRAVIS_BRANCH != "master" ]]; then
    echo ">>> won't try to create builds because this is a PR"
    exit 0
fi

echo ">>> ($0) additional builds of ES module for specified ES version"

# es61
./gradlew --stacktrace es61x:ror '-PesVersion=6.1.0'
#./gradlew --stacktrace es60x:ror '-PesVersion=6.1.1'


# es60
./gradlew --stacktrace es60x:ror '-PesVersion=6.0.0'
#./gradlew --stacktrace es60x:ror '-PesVersion=6.0.1'


# es53
./gradlew --stacktrace es53x:ror '-PesVersion=5.6.0'
./gradlew --stacktrace es53x:ror '-PesVersion=5.6.1'
./gradlew --stacktrace es53x:ror '-PesVersion=5.6.2'
./gradlew --stacktrace es53x:ror '-PesVersion=5.6.3'
./gradlew --stacktrace es53x:ror '-PesVersion=5.6.4'
#./gradlew --stacktrace es53x:ror '-PesVersion=5.6.5'

./gradlew --stacktrace es53x:ror '-PesVersion=5.5.0'
./gradlew --stacktrace es53x:ror '-PesVersion=5.5.1'
./gradlew --stacktrace es53x:ror '-PesVersion=5.5.2'
./gradlew --stacktrace es53x:ror '-PesVersion=5.5.3'

./gradlew --stacktrace es53x:ror '-PesVersion=5.4.0'
./gradlew --stacktrace es53x:ror '-PesVersion=5.4.1'
./gradlew --stacktrace es53x:ror '-PesVersion=5.4.2'
./gradlew --stacktrace es53x:ror '-PesVersion=5.4.3'

./gradlew --stacktrace es53x:ror '-PesVersion=5.3.0'
./gradlew --stacktrace es53x:ror '-PesVersion=5.3.1'
./gradlew --stacktrace es53x:ror '-PesVersion=5.3.2'
./gradlew --stacktrace es53x:ror '-PesVersion=5.3.3'


# es52
./gradlew --stacktrace es52x:ror '-PesVersion=5.2.0'
./gradlew --stacktrace es52x:ror '-PesVersion=5.2.1'
#./gradlew --stacktrace es52x:ror '-PesVersion=5.2.2'


# es51
./gradlew --stacktrace es51x:ror '-PesVersion=5.1.1'
#./gradlew --stacktrace es51x:ror '-PesVersion=5.1.2'

# es23x
./gradlew --stacktrace es23x:ror '-PesVersion=2.4.0'
./gradlew --stacktrace es23x:ror '-PesVersion=2.4.1'
#./gradlew --stacktrace es23x:ror '-PesVersion=2.4.2'
#./gradlew --stacktrace es23x:ror '-PesVersion=2.4.3'
./gradlew --stacktrace es23x:ror '-PesVersion=2.4.4'
./gradlew --stacktrace es23x:ror '-PesVersion=2.4.5'
#./gradlew --stacktrace es23x:ror '-PesVersion=2.4.6'

