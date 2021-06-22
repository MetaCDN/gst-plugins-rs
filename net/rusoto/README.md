# gst-plugin-s3

This is a [GStreamer](https://gstreamer.freedesktop.org/) plugin to interact
with [Amazon Web Services](https://aws.amazon.com/). We currently have elements
to interact with [S3](https://aws.amazon.com/s3) and
[Transcribe](https://aws.amazon.com/transcribe/).

## AWS Credentials

AWS credentials are picked up using the mechanism that
[rusoto's ChainProvider](https://rusoto.github.io/rusoto/rusoto_credential/struct.ChainProvider.html)
uses. At the moment, that is:

1.  Environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
2.  AWS credentials file. Usually located at ~/.aws/credentials.
3.  IAM instance profile. Will only work if running on an EC2 instance with an
    instance profile/role.

An example credentials file might look like:

```ini
[default]
aws_access_key_id = ...
aws_secret_access_key = ...
```

## s3src

Reads from a given S3 (region, bucket, object, version?) tuple. The version may
be omitted, in which case the default behaviour of fetching the latest version
applies.

```
$ gst-launch-1.0 \
    s3src uri=s3://ap-south-1/my-bucket/my-object-key/which-can-have-slashes?version=my-optional-version !
    filesink name=my-object.out
```

## s3sink

Writes data to a specified S3 (region, bucket, object, version?) tuple. The
version may be omitted.

```
$ gst-launch-1.0 \
    videotestsrc ! \
    theoraenc ! \
    oggmux ! \
    s3sink uri=s3://us-west-1/example-bucket/my/file.ogv?version=my-optional-version
```

## awstranscriber

Transcribes audio to text.
