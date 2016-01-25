from github3 import login
import os
from sys import exit
import shutil


release = []

def upload(file):
	name = os.path.basename(file)
	fdata = open(file, 'rb').read()
	mime = 'application/pdf'
	asset = release.upload_asset(mime, name, fdata)
	return asset



version = 'v0.7'
username = 'aviaryan'
repo = 'learnxinyminutes-pdf'
tokentxt = open('token.txt', 'r').read()
gh = login(token = tokentxt)

user = gh.user(username)
repo = gh.repository(username, repo)
print(user.name)

for i in repo.releases():
	print(i)
	release = i
	print(i.tag_name, 'name = ', i.name, i.body, i.id)
	break

# upload main pdf
# file = 'learnxinyminutes.pdf'
# print('Uploading ' + file)
# try:
# 	upload(file)
# except:
# 	print(file, 'upload failed')
# 	exit(1)

# upload single pdf's
for file in os.listdir('_pdfs'):
	print('Uploading ' + file)
	try:
		upload('_pdfs/' + file)
	except:
		print('Failed', file)

# upload all pdf
shutil.make_archive('learnxinyminutes_all', 'zip', '_pdfs') # the all pdf
try:
	upload('learnxinyminutes_all.zip')
except:
	print('all zip failed')

# release = repo.create_release(version)
# print(release.edit(body='test release by API'))

# x = "C:\\Users\\Avi\\Documents\\GitHub\\learnxinyminutes-pdf\\_pdfs\\java.pdf"
# file = open(x, 'rb').read()
# mime = 'application/pdf'
# name = 'java-test.pdf'

# asset = release.upload_asset(mime, name, file)