module.exports = (grunt) ->
    config =
        uglify:
            build:
                files:
                    "tmp/build.js" : [
                        "apps/default/assets/js/deps/jquery.pjax.js",
                        "apps/*/assets/js/*.js"
                    ]

        concat:
            options:
                separator: ";\n"
            build:
                src: [
                    "apps/default/assets/js/deps/jquery.min.js",
                    "tmp/build.js"
                ]
                dest: "public/assets/js/main.js"

        sass:
            options:
                style: "compressed"
            build:
                files:
                    "public/assets/css/style.min.css" : "sass/style.scss"

    grunt.initConfig config

    grunt.loadNpmTasks "grunt-contrib-uglify"
    grunt.loadNpmTasks "grunt-contrib-concat"
    grunt.loadNpmTasks "grunt-contrib-sass"

    grunt.registerTask "clean", ->
        grunt.file.delete "tmp/build.js", {force:true}

    grunt.registerTask "default", ["uglify", "concat", "clean", "sass"]
