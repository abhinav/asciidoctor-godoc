package main

import (
	"io/fs"
	"mime"
	"os"
	"path/filepath"

	"github.com/pulumi/pulumi-aws/sdk/v5/go/aws/s3"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
)

func main() {
	pulumi.Run(func(ctx *pulumi.Context) error {
		wd, err := os.Getwd()
		if err != nil {
			return err
		}

		bucket, err := s3.NewBucket(ctx, "asciidoctor-godoc-preview", &s3.BucketArgs{
			Website: s3.BucketWebsiteArgs{
				IndexDocument: pulumi.String("index.html"),
			},
		})
		if err != nil {
			return err
		}

		siteDir := filepath.Join(filepath.Dir(wd), "_site") // ../_site
		fs.WalkDir(os.DirFS(siteDir), ".", func(path string, d fs.DirEntry, err error) error {
			if err != nil || d.IsDir() {
				return err
			}

			args := s3.BucketObjectArgs{
				Acl:    pulumi.String("public-read"),
				Bucket: bucket.ID(),
				Source: pulumi.NewFileAsset(filepath.Join(siteDir, path)),
			}

			if mt := mime.TypeByExtension(filepath.Ext(path)); len(mt) > 0 {
				args.ContentType = pulumi.String(mt)
			}
			_, err = s3.NewBucketObject(ctx, path, &args)
			return err
		})

		// Export the name of the bucket
		ctx.Export("bucket", bucket.ID())
		ctx.Export("endpoint", pulumi.Sprintf("http://%s", bucket.WebsiteEndpoint))
		return nil
	})
}
