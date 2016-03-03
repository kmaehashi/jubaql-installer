# JubaQL Installer

A script to setup your JubaQL environment quickly.

## Run Modes

JubaQL has two Run Modes:

* **Development (Standalone) Mode** that runs in a single node without Hadoop.
* **Production (Distributed/YARN) Mode** that runs on Hadoop YARN cluster to provide better throughput.

This installer covers both modes, but it is recommended for JubaQL beginners to start with the Development Mode setup.

## Requirements

### To Build JubaQL

To run the installer, the following commands must be available in PATH:

* `java` (JDK 7 or later)
* `sbt`: see [official tutorlal](http://www.scala-sbt.org/0.13/tutorial/Setup.html) for setup instructions

**For Production Mode setup**, `hadoop` (Hadoop 2.x) command is also needed to deploy JubaQL JAR files onto HDFS.

### To Run JubaQL

Apache Spark 1.2.2 needs be installed.
Rest assured, the installation is quite easy:

```
$ wget "http://archive.apache.org/dist/spark/spark-1.2.2/spark-1.2.2-bin-hadoop2.4.tgz"
$ tar xf "spark-1.2.2-bin-hadoop2.4.tgz"
```

**For Development Mode setup**, [Jubatus](http://jubat.us/en/quickstart.html) servers must be installed and be available in PATH on the Gateway node.

**For Production Mode setup**, [Jubatus](http://jubat.us/en/quickstart.html) servers must be installed and be available in PATH on all YARN nodes.
In addition, the following environment is needed.

* Apache Hadoop (YARN/HDFS) cluster
* Apache Zookeeper cluster

If you are just trying Production Mode (in other words: not trying to build an actual "Production" environment), you can setup Hadoop and ZooKeeper using a pseudo-distributed (single-node) configuration.

## Build JubaQL

Clone `jubaql-installer` repository.

```
$ git clone https://github.com/kmaehashi/jubaql-installer.git
$ cd jubaql-installer
```

You need to create a `config` file.
You can copy the template `config.tmpl`.

```
$ cp config.tmpl config
```

Modify `config` file to fit with your environment.
In most cases, you only need to change `SPARK_DIST`, a path to the Spark installation directory.

Now run the following command to build everything from source.

```
$ ./build.sh
```

You will see `Done!` message if the build completed successfully.

**For Production Mode setup**, you need to run the following command to deploy built Jubatus-on-YARN JAR files to your HDFS environmnent.

```
$ ./deploy.sh
```

## Run JubaQL

Start JubaQL Gateway:

```
Development Mode:
$ ./start-gateway-dev.sh &

Production Mode:
$ ./start-gateway-prod.sh &
```

Then connect to the Gateway using JubaQL Client:

```
$ ./start-client.sh
```

See the [JubaQL Syntax Reference](http://jubat.us/en/jubaql/jubaql_syntax.html) for details about queries available in JubaQL.
