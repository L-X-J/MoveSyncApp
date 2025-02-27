import com.android.build.gradle.BaseExtension
import org.gradle.api.Project

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

subprojects {
    println("project: ${project.name}")
    project.gradle.afterProject {
        val android = project.properties["android"] as BaseExtension?
        if (android != null && android.namespace == null) {
            println(" ${project.name} namespace is null chane to ${project.group}")
            android.namespace = project.group.toString()
        }
    }
}


val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
